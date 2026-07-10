# 📚 IT Reference Library

> A personal collection of dark-themed interactive cheat sheets for daily IT, SysAdmin, DevOps, and Microsoft Cloud work.

---

## 📊 Library Stats

| Stat | Value |
|------|-------|
| 📁 Total Files | 8 cheat sheets |
| 🗂️ Categories | 3 (PowerShell, Linux, Microsoft Cloud) |
| 📜 Commands & Scripts | 500+ |
| 🎨 Theme | Dark — all files |
| 🛠️ Format | Standalone HTML (no dependencies) |

---

## 🪟 PowerShell & Windows

### 01 — `powershell-scripts.html`
**15 Essential Daily PowerShell Scripts**

Covers the most-used Windows Server administration scripts for daily ops.

| # | Script | What it does |
|---|--------|-------------|
| 1 | Check Server Uptime | Last boot time of local or remote server |
| 2 | Check Disk Space on Multiple Servers | Free and total disk space across a server list |
| 3 | Check CPU and Memory Usage | Real-time processor and memory counters |
| 4 | List Stopped Services | All stopped services sorted by display name |
| 5 | Restart a Service | Parameterised service restart |
| 6 | Check Windows Updates Installed Recently | Latest 20 installed hotfixes |
| 7 | Get Event Logs (Errors Last 24 Hours) | System log errors from the last day |
| 8 | Test Server Connectivity | Ping multiple servers from a list |
| 9 | Check RDP Sessions | Currently logged-in users (local & remote) |
| 10 | Get Top 10 Processes by Memory | Top memory consumers |
| 11 | Check Failed Login Attempts | Security event ID 4625 (last 24 hours) |
| 12 | VMware ESXi Host Ping Check | Connectivity to ESXi hosts |
| 13 | Export AD Users | All AD users exported to CSV |
| 14 | Find Expiring Passwords | Users with password older than 60 days |
| 15 | Daily Server Health Report | Complete snapshot: uptime, memory, disk, services |

> ✨ Features: Syntax highlighting · Copy buttons · PS 5.1+

---

### 02 — `intune-powershell-scripts.html`
**Top 15 PowerShell Scripts for Microsoft Intune**

Microsoft Graph PowerShell SDK scripts for automating Intune management.

| # | Script | What it does |
|---|--------|-------------|
| 1 | Connect to Microsoft Graph | Connect with required Device & Intune scopes |
| 2 | Get All Devices | All managed devices with OS and compliance state |
| 3 | Get Device Compliance Status | Compliance state per device |
| 4 | Get All Device Configuration Profiles | All config profiles with platform info |
| 5 | Get All Compliance Policies | All compliance policies with platform type |
| 6 | Get All Assigned Apps | All mobile apps and assignment status |
| 7 | Get Intune Users | All users with account enabled status |
| 8 | Get All Device Categories | Device categories with ID |
| 9 | Get All Conditional Access Policies | CA policy names, state, and conditions |
| 10 | Get All Windows Update Rings | Update rings with feature/quality update settings |
| 11 | Get All Enrolled Devices Count | Total enrolled device count |
| 12 | Get All Autopilot Devices | Autopilot devices with serial numbers |
| 13 | Get All Groups | All groups for assignment targeting |
| 14 | Export Devices to CSV | Full device export to `Intune-Devices.csv` |
| 15 | Get Intune Licensed Users Count | Count of users with Intune licence assigned |

> ✨ Features: Syntax highlighting · Copy buttons · Microsoft Graph SDK · Install panel

---

### 03 — `daily-it-problems.html`
**Daily IT Problems & How to Fix Them Fast**

12 common IT helpdesk issues with 3-step fixes, essential commands, and a daily routine.

| # | Problem | Quick Fix Steps |
|---|---------|----------------|
| 01 | Boot Loop | Safe Mode → Startup Repair → CHKDSK |
| 02 | Profile Corruption | New profile → Copy user data → Fix registry |
| 03 | Outlook Crashing | Disable add-ins → New profile → Repair Office |
| 04 | Wi-Fi, No Internet | Flush DNS → Renew IP → Check gateway |
| 05 | Overheating | Clean vents → Monitor CPU → Thermal paste |
| 06 | Printer Not Visible | Check perms → Restart Spooler → Reinstall driver |
| 07 | Updates Failing | Troubleshooter → Clear SoftDist. → DISM & SFC |
| 08 | High CPU Usage | Task Manager → Startup apps → Malware scan |
| 09 | Remote Desktop | Enable RDP → Check firewall → Test network |
| 10 | USB Not Found | Update drivers → Another port → Reinstall device |
| 11 | Network Drive Drops | Server connect. → Re-map drive → Check perms |
| 12 | Teams Mic/Camera | App permissions → Update drivers → Test in app |

**Essential Commands (clickable chips):**
`ipconfig /all` · `ping google.com` · `nslookup` · `net user` · `sfc /scannow` · `chkdsk /f` · `gpupdate /force` · `tasklist` · `shutdown /r /t 0`

**Daily IT Routine:** Check tickets → Prioritize critical → Resolve issues → Fix network → Install updates → Manage accounts → Document fixes → Follow up users → Monitor backups → End-of-day report

> ✨ Features: Colour-coded problem cards · Copy command chips · Incident routine

---

## 🐧 Linux & DevOps

### 04 — `linux-deployment-commands.html`
**Linux Commands for Daily Deployment Work**

Production-focused Linux reference grouped by deployment task.

| Category | Key Commands |
|----------|-------------|
| ✔️ Deployment Verification | `systemctl status`, `restart`, `reload` |
| 📋 Log Monitoring | `tail -f`, `journalctl -u`, `journalctl -n` |
| 🌐 Network Validation | `ss -tulnp`, `curl -I`, `ping`, `nc -zv` |
| ⚙️ Process Management | `ps aux --sort=-%cpu`, `pgrep`, `kill -9` |
| 💾 Disk Space | `df -h`, `du -sh *`, `find / -size +500M`, `lsof +L1` |
| 📦 Deployment | `tar -xvf`, `cp`, `rsync -avz` |
| 🔍 Search | `grep -i`, `grep -r`, `grep \| wc -l` |
| 👤 User & Permissions | `ls -lah`, `chown`, `chmod` |
| ☁️ AWS / System | `free -h`, `lsblk`, `vmstat 1 5` |

**Every Deployment Checklist (11 commands):**
`systemctl status app` · `journalctl -u app -f` · `tail -f application.log` · `curl localhost:8080` · `ss -tulnp` · `df -h` · `free -h` · `ps aux --sort=-%cpu | head` · `ps aux --sort=-%mem | head` · `find / -size +500M` · `lsof +L1`

**Incident Flow:** Observe → Investigate → Isolate → Fix → Verify

> ✨ Features: Copy on click · Production checklist · Pro tips panel · Incident response flow

---

### 05 — `linux-100-commands.html`
**100+ Linux Commands — Complete Cheat Sheet**

160 commands across 17 sections — the definitive Linux quick-reference.

| Section | Commands | Range |
|---------|----------|-------|
| 1. File & Directory | `pwd`, `ls`, `mkdir`, `cp`, `mv`, `rm`, `ln`… | #1–20 |
| 2. Viewing File Contents | `cat`, `tac`, `less`, `head`, `tail`, `od`… | #21–30 |
| 3. Text Processing | `grep`, `awk`, `sed`, `cut`, `sort`, `tee`… | #31–45 |
| 4. Search Commands | `find`, `locate`, `which`, `whereis`, `type` | #46–50 |
| 5. File Permissions | `chmod`, `chown`, `chgrp`, `umask`, `setfacl` | #51–56 |
| 6. User Management | `useradd`, `passwd`, `groupadd`, `id`, `whoami` | #57–66 |
| 7. Process Management | `ps`, `top`, `htop`, `kill`, `killall`, `nohup` | #67–79 |
| 8. System Information | `uname`, `uptime`, `lscpu`, `free`, `vmstat` | #80–92 |
| 9. Disk Management | `df`, `du`, `fdisk`, `mount`, `blkid` | #93–100 |
| 10. Networking | `ping`, `ip`, `ss`, `dig`, `curl`, `ssh`, `scp` | #101–115 |
| 11. Package Management | `rpm`, `yum`, `dnf`, `apt`, `dpkg` | #116–120 |
| 12. Service Management | `systemctl`, `service`, `journalctl`, `chkconfig` | #121–124 |
| 13. Archive & Compression | `tar`, `gzip`, `zip`, `unzip`, `bzip2` | #125–130 |
| 14. Cron & Scheduling | `crontab`, `at`, `atq`, `atrm` | #131–134 |
| 15. Shell Commands | `echo`, `alias`, `history`, `export`, `xargs` | #135–144 |
| 16. Log Monitoring | `journalctl -xe`, `tail -f`, `grep ERROR` | #145–149 |
| 17. Linux Admin Interview | `find`, `ps -ef \| grep`, `netstat`, `vmstat` | #150–160 |

> ✨ Features: Live search bar · Jump nav pills · Click-to-copy · 160 commands · Colour-coded sections

---

## ☁️ Microsoft Cloud & Intune

### 06 — `intune-win32-deployment.html`
**Microsoft Intune Fundamentals — Win32 App Deployment**

End-to-end guide to packaging, deploying, and monitoring Win32 apps in Intune.

| Section | Content |
|---------|---------|
| 1. What is Win32 App? | EXE, MSI, MSP, BAT, CMD, PowerShell packaging overview |
| 2. Deployment Flow | Package → Upload → Create → Assign → Install on Device |
| 3. Package Creation | IntuneWinAppUtil.exe command with copyable syntax |
| 4. Create Win32 App in Intune | 4-step wizard + install/uninstall command examples |
| 5. Detection Rules | File, Registry, MSI rule examples table |
| 6. Assign Win32 App | Required / Available / Uninstall / Without enrollment |
| 7. Installation Process | 5-step vertical flow: check → download → run → detect → complete |
| 8. Monitoring & Reports | Apps > Monitor checklist (status, logs, uninstall) |
| 9. Common Error Codes | 0x87D00213, 0x87D00607, 0x87D001F7, 0x87D00324, 0x87D00215 |
| 10. Best Practices | 7 production best practices |
| 11. Deployment Summary | Full 7-step summary flow |

> ✨ Features: Copyable commands · Error code reference · Detection rules table · Full deployment flow

---

### 07 — `intune-intro-architecture-ecosystem.html`
**Microsoft Intune Fundamentals — Introduction, Architecture & Ecosystem (Page 5)**

Conceptual foundation of Microsoft Intune for IT admins and cloud engineers.

| Section | Content |
|---------|---------|
| 1. What is Microsoft Intune? | MDM + MAM cloud management overview |
| 2. History of Intune | Timeline 2011 → 2020+ with key milestones |
| 3. Intune vs SCCM | 7-row comparison table (deployment, management, access, best for…) |
| 4. MEM Portal | endpoint.microsoft.com — what's included and what you can do |
| 5. Architecture Overview | Azure AD ↔ Intune ↔ Defender/M365/Autopilot/Analytics diagram |
| 6. Intune Ecosystem | 7 key integrations: Azure AD, Defender, M365, Autopilot, Analytics, Power Platform, ServiceNow |
| 7. Management Scope | Mobile, PCs, Virtual Desktops, Apps, Data & Access |
| 8. Cloud-Native MDM Benefits | 6 benefits + 100% Cloud badge |
| Why Intune is Important | 5 reasons: security, productivity, cost, AI, remote workforce |
| Quick Tip | Think of Intune as your cloud IT Command Center |

> ✨ Features: Architecture diagram · vs SCCM comparison · Ecosystem integrations · Key benefits

---

### 08 — `azure-ad-entra-id-overview.html`
**Azure AD (Entra ID) — Complete Overview Part 1**

Identity and access management fundamentals with Microsoft Entra ID.

| Section | Content |
|---------|---------|
| 1. What is Azure AD (Entra ID)? | Cloud identity & access management definition |
| 2. How Entra ID Works | User → Entra ID → Auth/Authz → Resources flow |
| 3. Core Components | Users, Groups, Applications, Devices, Tenants table |
| 4. Types of Identities | Member, Guest, External, Managed Identity |
| 5. Authentication Methods | Password, Authenticator, SMS OTP, FIDO2, Certificate |
| 6. Single Sign-On (SSO) | SAML / OAuth 2.0 / OpenID Connect flow diagram |
| 7. Conditional Access | 5 signals (User, Device, Location, App, Risk) → Allow/Block |
| 8. Licenses of Entra ID | Free / P1 / P2 / External ID feature comparison |
| 9. Azure AD Connect | On-premises AD ⇄ Azure AD Connect ⇄ Entra ID hybrid flow |
| 10. Key Benefits | 5 benefits + "Secure Identities, Secure Everything!" badge |
| Bonus Terms | Tenant, App Registration, Enterprise App, Object ID, Directory Role |

> ✨ Features: SSO flow diagram · CA signal cards · Licence table · AD Connect hybrid flow · Bonus terms

---

## 💡 How to Use This Library

- **Open** any `.html` file directly in your browser — no server needed.
- **Copy buttons** are on every command — hover to reveal, click to copy.
- **Live search** is available in `linux-100-commands.html` to filter all 160 commands.
- **Print to PDF** from your browser for offline hard-copy reference.
- **Bookmark** this README as the library home page.
- All files are **fully self-contained** — no internet connection required after download.

---

## 🗂️ File Index

| # | File | Category | Size |
|---|------|----------|------|
| 01 | `powershell-scripts.html` | PowerShell & Windows | ~11 KB |
| 02 | `intune-powershell-scripts.html` | PowerShell & Windows | ~14 KB |
| 03 | `daily-it-problems.html` | PowerShell & Windows | ~11 KB |
| 04 | `linux-deployment-commands.html` | Linux & DevOps | ~18 KB |
| 05 | `linux-100-commands.html` | Linux & DevOps | ~25 KB |
| 06 | `intune-win32-deployment.html` | Microsoft Cloud | ~29 KB |
| 07 | `intune-intro-architecture-ecosystem.html` | Microsoft Cloud | ~28 KB |
| 08 | `azure-ad-entra-id-overview.html` | Microsoft Cloud | ~27 KB |
| 00 | `README.md` | — | This file |

---

## 🏷️ Tags

`#SysAdmin` `#DevOps` `#PowerShell` `#Linux` `#MicrosoftIntune` `#AzureAD` `#EntraID` `#MicrosoftGraph` `#Win32` `#MDM` `#HelpDesk` `#ITSupport` `#CloudEngineering` `#SRE`

---

*Built with ♥ using Claude · Dark Theme · HTML · No Dependencies*
