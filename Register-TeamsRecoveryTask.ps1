<#
.SYNOPSIS
    Installs Repair-MSTeams.ps1 and registers a logon scheduled task that runs it
    in the context of whichever user signs in.

.DESCRIPTION
    - Copies Repair-MSTeams.ps1 to C:\ProgramData\TeamsRecovery
    - Locks the folder down (Admins/SYSTEM full control, Users read & execute only),
      so a standard user cannot tamper with a script that other users will run
    - Registers task "Teams Recovery": at logon of any user, after a short delay,
      runs the script with -OnlyIfUnhealthy as that user (limited rights)

    Run from an ELEVATED PowerShell prompt, with both .ps1 files in the same folder.

    To remove:  Unregister-ScheduledTask -TaskName 'Teams Recovery' -Confirm:$false
#>

#Requires -RunAsAdministrator
[CmdletBinding()]
param(
    [string]$SourceScript      = (Join-Path $PSScriptRoot 'Repair-MSTeams.ps1'),
    [string]$InstallDir        = 'C:\ProgramData\TeamsRecovery',
    [string]$TaskName          = 'Teams Recovery',
    [int]$LogonDelayMinutes    = 2
)

$ErrorActionPreference = 'Stop'

if (-not (Test-Path $SourceScript)) { throw "Source script not found: $SourceScript" }

# 1. Install the script
New-Item -ItemType Directory -Path $InstallDir -Force | Out-Null
$target = Join-Path $InstallDir 'Repair-MSTeams.ps1'
Copy-Item -Path $SourceScript -Destination $target -Force

# 2. Lock down permissions (SIDs keep this independent of OS language)
#    S-1-5-18 = SYSTEM, S-1-5-32-544 = Administrators, S-1-5-32-545 = Users
& icacls.exe $InstallDir /inheritance:r /grant:r '*S-1-5-18:(OI)(CI)F' '*S-1-5-32-544:(OI)(CI)F' '*S-1-5-32-545:(OI)(CI)RX' | Out-Null
if ($LASTEXITCODE -ne 0) { throw "icacls failed with exit code $LASTEXITCODE" }

# 3. Register the scheduled task
$action = New-ScheduledTaskAction -Execute 'powershell.exe' `
    -Argument "-NoProfile -NonInteractive -WindowStyle Hidden -ExecutionPolicy Bypass -File `"$target`" -OnlyIfUnhealthy"

$trigger       = New-ScheduledTaskTrigger -AtLogOn
$trigger.Delay = "PT${LogonDelayMinutes}M"   # let the desktop and Teams autostart settle first

$principal = New-ScheduledTaskPrincipal -GroupId 'S-1-5-32-545' -RunLevel Limited

$settings = New-ScheduledTaskSettingsSet `
    -AllowStartIfOnBatteries `
    -DontStopIfGoingOnBatteries `
    -StartWhenAvailable `
    -MultipleInstances IgnoreNew `
    -ExecutionTimeLimit (New-TimeSpan -Minutes 30)

Register-ScheduledTask -TaskName $TaskName `
    -Action $action -Trigger $trigger -Principal $principal -Settings $settings `
    -Description 'Detects a broken new Microsoft Teams at logon and repairs it (Terminate > Repair > Reset).' `
    -Force | Out-Null

Write-Host "Installed script : $target"
Write-Host "Registered task  : $TaskName (runs $LogonDelayMinutes min after any user logs on)"
Write-Host "Per-user log     : %LOCALAPPDATA%\TeamsRecovery\TeamsRecovery.log"
