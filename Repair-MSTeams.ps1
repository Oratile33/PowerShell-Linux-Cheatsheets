<#
.SYNOPSIS
    Detects and recovers the new Microsoft Teams (MSIX package "MSTeams") when it fails to start.

.DESCRIPTION
    Automates the same three actions found under
    Settings > Apps > Installed apps > Microsoft Teams > Advanced options:

        1. TERMINATE - stops every process that belongs to the Teams package
        2. REPAIR    - re-registers the package (keeps user data)
        3. RESET     - clears the app data/cache (user will have to sign in again)

    MODES
        (no switch)        Manual recovery. Escalates: Terminate -> test -> Repair -> test -> Reset -> test.
                           Stops as soon as Teams starts successfully.
        -CheckOnly/-Detect Health check only. Makes NO changes. Exit 0 = healthy, 1 = unhealthy.
        -OnlyIfUnhealthy   For the logon scheduled task. Runs the health check first and only
                           performs recovery if a problem is found. Has a cooldown so a machine
                           that can't be fixed is not Reset on every logon.

    HEALTH SIGNALS (non-intrusive)
        - Package status is not 'Ok' (e.g. NeedsRemediation after a bad update)
        - AppxManifest.xml missing from the install location
        - ms-teams.exe crash (Event 1000) or hang (Event 1002) in the Application log
          since the last recovery run, within the lookback window
        - Optional -ProbeLaunch: actually launches Teams and checks it stays running

    IMPORTANT: Run in the USER context (the signed-in user), not as SYSTEM.
    MSIX packages and their data are per-user.

.PARAMETER CheckOnly
    Health check only, no changes. Alias: -Detect

.PARAMETER OnlyIfUnhealthy
    Run recovery only when the health check finds a problem (used by the scheduled task).

.PARAMETER ProbeLaunch
    Include a live launch test in the health check (launches Teams if it isn't running).

.PARAMETER ForceAll
    Run Terminate, Repair and Reset unconditionally, in that order.

.PARAMETER LookbackHours
    How far back to look for Teams crash/hang events. Default 24.

.PARAMETER CrashThreshold
    Number of crash/hang events that counts as unhealthy. Default 1.

.PARAMETER CooldownHours
    With -OnlyIfUnhealthy: minimum hours between recovery runs. Default 12.

.PARAMETER StartupWaitSeconds
    How long Teams must stay alive after launch to count as "started". Default 25.

.PARAMETER LogPath
    Log file. Default: %LOCALAPPDATA%\TeamsRecovery\TeamsRecovery.log

.EXAMPLE
    .\Repair-MSTeams.ps1 -CheckOnly
.EXAMPLE
    .\Repair-MSTeams.ps1 -Detect -ProbeLaunch
.EXAMPLE
    .\Repair-MSTeams.ps1 -OnlyIfUnhealthy
.EXAMPLE
    .\Repair-MSTeams.ps1 -ForceAll

.NOTES
    Exit codes: 0 = healthy / recovered, 1 = unhealthy (CheckOnly) or still failing after all steps,
                2 = new Teams not installed for this user, 3 = skipped (cooldown active).
#>

[CmdletBinding()]
param(
    [Alias('Detect')]
    [switch]$CheckOnly,
    [switch]$OnlyIfUnhealthy,
    [switch]$ProbeLaunch,
    [switch]$ForceAll,
    [ValidateRange(1, 720)]
    [int]$LookbackHours = 24,
    [ValidateRange(1, 50)]
    [int]$CrashThreshold = 1,
    [ValidateRange(0, 720)]
    [int]$CooldownHours = 12,
    [ValidateRange(5, 120)]
    [int]$StartupWaitSeconds = 25,
    [string]$LogPath = (Join-Path $env:LOCALAPPDATA 'TeamsRecovery\TeamsRecovery.log')
)

$ErrorActionPreference = 'Stop'

$PackageName   = 'MSTeams'
$PackageFamily = 'MSTeams_8wekyb3d8bbwe'
$AppUserModel  = "$PackageFamily!MSTeams"
$ProcessName   = 'ms-teams'
$StatePath     = Join-Path (Split-Path $LogPath -Parent) 'state.json'

# ----------------------------------------------------------------------------
# Helpers
# ----------------------------------------------------------------------------
function Write-Log {
    param([string]$Message, [ValidateSet('INFO', 'WARN', 'ERROR')][string]$Level = 'INFO')
    $line = '{0} [{1}] {2}' -f (Get-Date -Format 'yyyy-MM-dd HH:mm:ss'), $Level, $Message
    Write-Host $line
    try {
        $dir = Split-Path $LogPath -Parent
        if (-not (Test-Path $dir)) { New-Item -ItemType Directory -Path $dir -Force | Out-Null }
        Add-Content -Path $LogPath -Value $line
    } catch { }
}

function Get-State {
    if (Test-Path $StatePath) {
        try { return (Get-Content -Path $StatePath -Raw | ConvertFrom-Json) } catch { }
    }
    return $null
}

function Set-State {
    param([bool]$Recovered)
    try {
        $dir = Split-Path $StatePath -Parent
        if (-not (Test-Path $dir)) { New-Item -ItemType Directory -Path $dir -Force | Out-Null }
        [pscustomobject]@{
            LastRunTicksUtc = (Get-Date).ToUniversalTime().Ticks
            LastResult      = $(if ($Recovered) { 'Recovered' } else { 'Failed' })
        } | ConvertTo-Json | Set-Content -Path $StatePath
    } catch {
        Write-Log "Could not write state file: $($_.Exception.Message)" 'WARN'
    }
}

function Get-LastRunLocal {
    $s = Get-State
    if ($s -and $s.LastRunTicksUtc) {
        return ([datetime]::new([long]$s.LastRunTicksUtc, [DateTimeKind]::Utc)).ToLocalTime()
    }
    return $null
}

function Get-TeamsPackage {
    Get-AppxPackage -Name $PackageName -ErrorAction SilentlyContinue | Select-Object -First 1
}

# ----------------------------------------------------------------------------
# Recovery actions
# ----------------------------------------------------------------------------
function Stop-Teams {
    Write-Log 'TERMINATE: stopping Teams processes...'
    $session = (Get-Process -Id $PID).SessionId

    # Everything that belongs to the Teams package (ms-teams.exe plus its WebView2
    # helper processes, which carry the package family in their command line).
    $targets = Get-CimInstance Win32_Process | Where-Object {
        $_.SessionId -eq $session -and (
            $_.Name -eq 'ms-teams.exe' -or
            $_.ExecutablePath -like '*\WindowsApps\MSTeams_*' -or
            $_.CommandLine -like "*$PackageFamily*"
        )
    }

    if (-not $targets) {
        Write-Log 'No Teams processes were running.'
        return
    }

    foreach ($p in $targets) {
        try {
            Stop-Process -Id $p.ProcessId -Force -ErrorAction Stop
            Write-Log "Stopped $($p.Name) (PID $($p.ProcessId))."
        } catch {
            Write-Log "Could not stop $($p.Name) (PID $($p.ProcessId)): $($_.Exception.Message)" 'WARN'
        }
    }
    Start-Sleep -Seconds 3
}

function Repair-Teams {
    Write-Log 'REPAIR: re-registering the Teams package (user data is kept)...'
    $pkg = Get-TeamsPackage
    if (-not $pkg) { throw 'Teams package not found.' }

    Write-Log "Package version $($pkg.Version), status '$($pkg.Status)'."
    $manifest = Join-Path $pkg.InstallLocation 'AppxManifest.xml'
    if (-not (Test-Path $manifest)) { throw "Manifest not found at $manifest" }

    Add-AppxPackage -Register $manifest -DisableDevelopmentMode -ForceApplicationShutdown | Out-Null
    Write-Log 'Re-registration completed.'
}

function Reset-Teams {
    Write-Log 'RESET: clearing Teams app data (user will need to sign in again)...'
    $pkg = Get-TeamsPackage
    if (-not $pkg) { throw 'Teams package not found.' }

    # Preferred: the built-in cmdlet (Windows 11 22H2+), same engine as Settings > Reset
    if (Get-Command Reset-AppxPackage -ErrorAction SilentlyContinue) {
        $pkg | Reset-AppxPackage | Out-Null
        Write-Log 'Reset-AppxPackage completed.'
        return
    }

    # Fallback for Windows 10 / older builds: clear the package data folders manually
    Write-Log 'Reset-AppxPackage not available, clearing package data manually.' 'WARN'
    $root = Join-Path $env:LOCALAPPDATA "Packages\$PackageFamily"
    foreach ($folder in 'LocalCache', 'LocalState', 'TempState', 'RoamingState', 'Settings') {
        $path = Join-Path $root $folder
        if (Test-Path $path) {
            try {
                Get-ChildItem -Path $path -Force -ErrorAction SilentlyContinue |
                    Remove-Item -Recurse -Force -ErrorAction Stop
                Write-Log "Cleared $folder."
            } catch {
                Write-Log "Could not fully clear $folder`: $($_.Exception.Message)" 'WARN'
            }
        }
    }
    # Re-register so the app starts from a clean, registered state
    Add-AppxPackage -Register (Join-Path $pkg.InstallLocation 'AppxManifest.xml') -DisableDevelopmentMode | Out-Null
    Write-Log 'Manual reset completed.'
}

function Test-TeamsStarts {
    Write-Log "Launching Teams and watching it for $StartupWaitSeconds seconds..."
    try {
        Start-Process -FilePath 'explorer.exe' -ArgumentList "shell:AppsFolder\$AppUserModel"
    } catch {
        Write-Log "Launch failed: $($_.Exception.Message)" 'ERROR'
        return $false
    }

    $deadline  = (Get-Date).AddSeconds($StartupWaitSeconds)
    $seenAlive = $false
    while ((Get-Date) -lt $deadline) {
        Start-Sleep -Seconds 2
        $proc = Get-Process -Name $ProcessName -ErrorAction SilentlyContinue
        if ($proc) {
            $seenAlive = $true
            if ($proc | Where-Object { -not $_.Responding }) {
                Write-Log 'Teams is running but not responding.' 'WARN'
                return $false
            }
        } elseif ($seenAlive) {
            Write-Log 'Teams started and then exited (crash).' 'WARN'
            return $false
        }
    }

    if ($seenAlive) { Write-Log 'Teams is running.'; return $true }
    Write-Log 'Teams never appeared as a running process.' 'WARN'
    return $false
}

function Invoke-Recovery {
    # Step 1 - Terminate
    Stop-Teams
    if (-not $ForceAll -and (Test-TeamsStarts)) { Write-Log 'Recovered after TERMINATE.'; return $true }

    # Step 2 - Repair
    Stop-Teams
    Repair-Teams
    if (-not $ForceAll -and (Test-TeamsStarts)) { Write-Log 'Recovered after REPAIR.'; return $true }

    # Step 3 - Reset
    Stop-Teams
    Reset-Teams
    if (Test-TeamsStarts) { Write-Log 'Recovered after RESET.'; return $true }

    return $false
}

# ----------------------------------------------------------------------------
# Detection (read-only)
# ----------------------------------------------------------------------------
function Get-TeamsHealth {
    $reasons = New-Object System.Collections.Generic.List[string]

    $pkg = Get-TeamsPackage
    if (-not $pkg) {
        return [pscustomobject]@{ Installed = $false; Healthy = $false; Reasons = @('New Teams is not installed') }
    }

    # 1. Package state
    if ("$($pkg.Status)" -ne 'Ok') {
        $reasons.Add("Package status is '$($pkg.Status)'")
    }
    if (-not (Test-Path (Join-Path $pkg.InstallLocation 'AppxManifest.xml'))) {
        $reasons.Add('AppxManifest.xml is missing from the install location')
    }

    # 2. Crash / hang events since the last recovery run (or the lookback window)
    $since   = (Get-Date).AddHours(-$LookbackHours)
    $lastRun = Get-LastRunLocal
    if ($lastRun -and $lastRun -gt $since) { $since = $lastRun }

    $events = @(Get-WinEvent -FilterHashtable @{
            LogName   = 'Application'
            Id        = 1000, 1002
            StartTime = $since
        } -ErrorAction SilentlyContinue |
        Where-Object {
            $_.ProviderName -in 'Application Error', 'Application Hang' -and
            $_.Message -match 'ms-teams\.exe'
        })

    if ($events.Count -ge $CrashThreshold) {
        $reasons.Add("$($events.Count) Teams crash/hang event(s) since $($since.ToString('yyyy-MM-dd HH:mm'))")
    }

    # 3. Optional live launch probe
    if ($ProbeLaunch -and $reasons.Count -eq 0) {
        if (-not (Test-TeamsStarts)) { $reasons.Add('Launch probe failed') }
    }

    return [pscustomobject]@{
        Installed = $true
        Healthy   = ($reasons.Count -eq 0)
        Reasons   = $reasons.ToArray()
    }
}

# ----------------------------------------------------------------------------
# Main
# ----------------------------------------------------------------------------
$mode = if ($CheckOnly) { 'CheckOnly' } elseif ($OnlyIfUnhealthy) { 'OnlyIfUnhealthy' } else { 'Manual' }
Write-Log "=== Teams recovery started (mode: $mode, user: $env:USERNAME, computer: $env:COMPUTERNAME) ==="

try {
    # ---- Detect only -------------------------------------------------------
    if ($CheckOnly) {
        $health = Get-TeamsHealth
        if (-not $health.Installed) { Write-Log $health.Reasons[0] 'ERROR'; exit 2 }
        if ($health.Healthy) { Write-Log 'RESULT: HEALTHY - no problems detected.'; exit 0 }
        Write-Log ('RESULT: UNHEALTHY - ' + ($health.Reasons -join '; ')) 'WARN'
        exit 1
    }

    if (-not (Get-TeamsPackage)) {
        Write-Log 'New Microsoft Teams (MSTeams package) is not installed for this user. Nothing to do.' 'ERROR'
        exit 2
    }

    # ---- Gate for the scheduled task ----------------------------------------
    if ($OnlyIfUnhealthy) {
        $lastRun = Get-LastRunLocal
        if ($lastRun -and ((Get-Date) - $lastRun).TotalHours -lt $CooldownHours) {
            Write-Log "Skipped: last recovery run was at $($lastRun.ToString('yyyy-MM-dd HH:mm')), cooldown is $CooldownHours h." 'WARN'
            exit 3
        }

        $health = Get-TeamsHealth
        if ($health.Healthy) { Write-Log 'Teams looks healthy. No action taken.'; exit 0 }
        Write-Log ('Teams is UNHEALTHY - ' + ($health.Reasons -join '; ') + '. Starting recovery.') 'WARN'
    }

    # ---- Recovery ------------------------------------------------------------
    $ok = @(Invoke-Recovery)[-1]
    Set-State -Recovered ([bool]$ok)

    if ($ok) { exit 0 }

    Write-Log 'Teams still fails to start after Terminate, Repair and Reset. Escalate: reinstall Teams / check Windows Event Log (AppModel-Runtime, Application Error).' 'ERROR'
    exit 1
}
catch {
    Write-Log "Script failed: $($_.Exception.Message)" 'ERROR'
    exit 1
}
