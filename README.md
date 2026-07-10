<!DOCTYPE html>
<html lang="en">
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<title>IT Reference Library — README</title>
<style>
@import url('https://fonts.googleapis.com/css2?family=JetBrains+Mono:wght@400;500;600&family=Inter:wght@400;500;600;700;800&display=swap');

*,*::before,*::after{box-sizing:border-box;margin:0;padding:0;}

:root{
  --bg:#07090f;
  --s1:#0b0f1c;
  --s2:#0f1525;
  --s3:#131a2e;
  --border:#1a2240;
  --border2:#1e2d55;
  --text:#d8e2ff;
  --muted:#4a5a88;

  --blue:#4a9eff;
  --cyan:#00e5ff;
  --green:#00e676;
  --amber:#ffca28;
  --orange:#ff7043;
  --purple:#ce93d8;
  --red:#ff5252;
  --teal:#1de9b6;
  --sky:#40c4ff;
  --pink:#f48fb1;
  --lime:#aed581;
  --indigo:#7986cb;
}

html{scroll-behavior:smooth;}
body{
  font-family:'Inter',sans-serif;
  background:var(--bg);
  color:var(--text);
  min-height:100vh;
  padding:2.5rem 1rem 5rem;
}

/* ── HEADER ─────────────────────────── */
header{text-align:center;margin-bottom:3rem;}
.terminal-bar{
  display:inline-flex;align-items:center;gap:.5rem;
  background:var(--s2);border:1px solid var(--border2);
  border-radius:8px 8px 0 0;padding:.4rem .9rem;
  margin-bottom:0;
}
.t-dot{width:.55rem;height:.55rem;border-radius:50%;}
.terminal-body{
  background:var(--s1);border:1px solid var(--border2);border-top:none;
  border-radius:0 0 10px 10px;
  padding:1.25rem 1.5rem 1.5rem;
  max-width:700px;margin:0 auto;text-align:left;
}
.prompt{font-family:'JetBrains Mono',monospace;font-size:.8rem;color:var(--muted);}
.prompt .p-user{color:var(--green);}
.prompt .p-path{color:var(--cyan);}
.prompt .p-cmd{color:var(--text);}
.big-title{
  font-size:clamp(1.8rem,5vw,3rem);font-weight:800;
  letter-spacing:-.025em;line-height:1.1;
  margin:1.25rem 0 .5rem;
}
.big-title .hl{
  background:linear-gradient(90deg,var(--cyan),var(--blue),var(--purple));
  -webkit-background-clip:text;-webkit-text-fill-color:transparent;background-clip:text;
}
.tagline{color:var(--muted);font-size:.9rem;margin-bottom:1rem;}

.meta-row{
  display:flex;align-items:center;justify-content:center;
  gap:.75rem;flex-wrap:wrap;margin-top:.75rem;
}
.meta-pill{
  display:inline-flex;align-items:center;gap:.4rem;
  background:var(--s3);border:1px solid var(--border2);
  border-radius:20px;padding:.3rem .8rem;
  font-family:'JetBrains Mono',monospace;font-size:.68rem;color:var(--muted);
}
.meta-pill .dot{width:.45rem;height:.45rem;border-radius:50%;flex-shrink:0;}

/* ── STATS ───────────────────────────── */
.stats{
  display:flex;gap:.75rem;justify-content:center;flex-wrap:wrap;
  max-width:700px;margin:2rem auto 0;
}
.stat{
  background:var(--s2);border:1px solid var(--border2);border-radius:10px;
  padding:.75rem 1.25rem;text-align:center;flex:1;min-width:100px;
}
.stat .sv{font-size:1.6rem;font-weight:800;font-family:'JetBrains Mono',monospace;line-height:1;}
.stat .sl{font-size:.67rem;color:var(--muted);margin-top:.3rem;text-transform:uppercase;letter-spacing:.08em;}

/* ── SECTION HEADINGS ─────────────────── */
.section-heading{
  max-width:900px;margin:2.5rem auto .9rem;
  display:flex;align-items:center;gap:.75rem;
}
.sh-line{flex:1;height:1px;background:var(--border2);}
.sh-text{
  font-size:.68rem;font-weight:700;letter-spacing:.18em;text-transform:uppercase;
  color:var(--muted);white-space:nowrap;
}

/* ── CARD GRID ───────────────────────── */
.grid{
  display:grid;
  grid-template-columns:repeat(auto-fill,minmax(260px,1fr));
  gap:.9rem;
  max-width:900px;
  margin:0 auto;
}

/* ── FILE CARD ───────────────────────── */
.file-card{
  background:var(--s1);
  border:1px solid var(--border);
  border-radius:12px;
  overflow:hidden;
  display:flex;flex-direction:column;
  transition:transform .15s,border-color .2s,box-shadow .2s;
  text-decoration:none;color:inherit;
  cursor:pointer;
  position:relative;
}
.file-card:hover{
  transform:translateY(-3px);
  border-color:var(--accent);
  box-shadow:0 8px 30px rgba(0,0,0,.4);
}
.card-stripe{height:3px;width:100%;}
.card-inner{padding:.85rem 1rem .95rem;flex:1;display:flex;flex-direction:column;gap:.55rem;}

.card-top{display:flex;align-items:flex-start;gap:.65rem;}
.card-emoji{font-size:1.6rem;flex-shrink:0;line-height:1;}
.card-meta{flex:1;}
.card-num{
  font-family:'JetBrains Mono',monospace;font-size:.6rem;font-weight:700;
  color:var(--muted);margin-bottom:.15rem;
}
.card-name{font-size:.88rem;font-weight:700;color:var(--text);line-height:1.25;}
.card-cat{
  display:inline-block;
  font-size:.6rem;font-weight:700;text-transform:uppercase;letter-spacing:.08em;
  padding:.1rem .45rem;border-radius:4px;margin-top:.35rem;
}
.card-desc{font-size:.75rem;color:#7a8fb8;line-height:1.5;}

.card-footer{
  display:flex;align-items:center;justify-content:space-between;
  padding:.55rem 1rem;border-top:1px solid var(--border);
  background:var(--s2);
}
.filename{
  font-family:'JetBrains Mono',monospace;font-size:.62rem;color:var(--muted);
  white-space:nowrap;overflow:hidden;text-overflow:ellipsis;flex:1;margin-right:.5rem;
}
.open-btn{
  font-size:.65rem;font-weight:700;color:#000;
  padding:.2rem .6rem;border-radius:4px;border:none;cursor:pointer;
  white-space:nowrap;transition:opacity .15s;flex-shrink:0;
}
.open-btn:hover{opacity:.85;}

/* ── LEGEND ──────────────────────────── */
.legend{
  max-width:900px;margin:2.5rem auto 0;
  background:var(--s1);border:1px solid var(--border);border-radius:12px;
  padding:1.1rem 1.3rem;
}
.legend-title{font-size:.68rem;font-weight:700;text-transform:uppercase;letter-spacing:.14em;color:var(--muted);margin-bottom:.75rem;}
.legend-grid{display:grid;grid-template-columns:repeat(auto-fill,minmax(160px,1fr));gap:.5rem;}
.legend-item{display:flex;align-items:center;gap:.5rem;font-size:.75rem;color:#7a8fb8;}
.legend-dot{width:.7rem;height:.7rem;border-radius:3px;flex-shrink:0;}

/* ── QUICK TIPS ──────────────────────── */
.tips-box{
  max-width:900px;margin:1rem auto 0;
  background:var(--s1);border:1px solid var(--border);border-radius:12px;
  padding:1.1rem 1.3rem;
}
.tips-title{font-size:.68rem;font-weight:700;text-transform:uppercase;letter-spacing:.14em;color:var(--amber);margin-bottom:.65rem;display:flex;align-items:center;gap:.4rem;}
.tips-grid{display:grid;grid-template-columns:1fr 1fr;gap:.4rem .9rem;}
@media(max-width:500px){.tips-grid{grid-template-columns:1fr;}}
.tip-item{display:flex;align-items:flex-start;gap:.45rem;font-size:.77rem;color:#7a8fb8;line-height:1.4;}
.tip-arrow{color:var(--cyan);flex-shrink:0;}

/* ── FOOTER ──────────────────────────── */
footer{
  text-align:center;margin-top:3rem;
  font-family:'JetBrains Mono',monospace;font-size:.72rem;color:var(--muted);
}
footer span{color:var(--cyan);}
footer .heart{color:var(--red);}

@media(max-width:500px){.grid{grid-template-columns:1fr;}}
</style>
</head>
<body>

<!-- HEADER -->
<header>
  <div style="max-width:700px;margin:0 auto;">
    <div class="terminal-bar">
      <div class="t-dot" style="background:#ff5f57;"></div>
      <div class="t-dot" style="background:#febc2e;"></div>
      <div class="t-dot" style="background:#28c840;"></div>
      <span style="font-family:'JetBrains Mono',monospace;font-size:.68rem;color:var(--muted);margin-left:.5rem;">~/it-reference-library/README.html</span>
    </div>
    <div class="terminal-body">
      <div class="prompt"><span class="p-user">sungu</span><span style="color:var(--muted);">@</span><span class="p-path">it-library</span><span style="color:var(--muted);"> ~$ </span><span class="p-cmd">cat README.html</span></div>
    </div>
  </div>

  <div class="big-title"><span class="hl">IT Reference Library</span></div>
  <p class="tagline">A personal collection of dark-themed interactive cheat sheets for daily IT work.</p>

  <div class="meta-row">
    <div class="meta-pill"><div class="dot" style="background:var(--green);"></div>8 Files</div>
    <div class="meta-pill"><div class="dot" style="background:var(--cyan);"></div>3 Categories</div>
    <div class="meta-pill"><div class="dot" style="background:var(--purple);"></div>500+ Commands & Scripts</div>
    <div class="meta-pill"><div class="dot" style="background:var(--amber);"></div>All Dark Theme</div>
  </div>

  <div class="stats">
    <div class="stat"><div class="sv" style="color:var(--cyan);">3</div><div class="sl">PowerShell Sheets</div></div>
    <div class="stat"><div class="sv" style="color:var(--green);">2</div><div class="sl">Linux Sheets</div></div>
    <div class="stat"><div class="sv" style="color:var(--blue);">3</div><div class="sl">Microsoft Cloud</div></div>
    <div class="stat"><div class="sv" style="color:var(--amber);">8</div><div class="sl">Total Files</div></div>
  </div>
</header>

<!-- CATEGORY: POWERSHELL -->
<div class="section-heading">
  <div class="sh-line"></div>
  <div class="sh-text">🪟 PowerShell & Windows</div>
  <div class="sh-line"></div>
</div>

<div class="grid" id="grid-ps"></div>

<!-- CATEGORY: LINUX -->
<div class="section-heading">
  <div class="sh-line"></div>
  <div class="sh-text">🐧 Linux & DevOps</div>
  <div class="sh-line"></div>
</div>

<div class="grid" id="grid-linux"></div>

<!-- CATEGORY: MICROSOFT CLOUD -->
<div class="section-heading">
  <div class="sh-line"></div>
  <div class="sh-text">☁️ Microsoft Cloud & Intune</div>
  <div class="sh-line"></div>
</div>

<div class="grid" id="grid-cloud"></div>

<!-- LEGEND -->
<div class="legend">
  <div class="legend-title">Category Colour Key</div>
  <div class="legend-grid" id="legend"></div>
</div>

<!-- TIPS -->
<div class="tips-box">
  <div class="tips-title">💡 How to Use This Library</div>
  <div class="tips-grid">
    <div class="tip-item"><span class="tip-arrow">›</span><span>Click <strong style="color:var(--text);">Open</strong> on any card to launch the cheat sheet in your browser.</span></div>
    <div class="tip-item"><span class="tip-arrow">›</span><span>All sheets have <strong style="color:var(--text);">copy buttons</strong> — hover over any command to reveal it.</span></div>
    <div class="tip-item"><span class="tip-arrow">›</span><span>Linux 100+ sheet has a <strong style="color:var(--text);">live search bar</strong> to filter all 160 commands instantly.</span></div>
    <div class="tip-item"><span class="tip-arrow">›</span><span>Bookmark this README as your <strong style="color:var(--text);">library home page</strong>.</span></div>
    <div class="tip-item"><span class="tip-arrow">›</span><span>All files are <strong style="color:var(--text);">standalone HTML</strong> — no internet required after download.</span></div>
    <div class="tip-item"><span class="tip-arrow">›</span><span>Print any sheet to PDF from your browser for <strong style="color:var(--text);">offline reference</strong>.</span></div>
  </div>
</div>

<footer>
  <div>Built with <span class="heart">♥</span> using Claude · Dark Theme · HTML · No Dependencies</div>
  <div style="margin-top:.4rem;"><span>#SysAdmin</span> · <span>#DevOps</span> · <span>#Intune</span> · <span>#PowerShell</span> · <span>#Linux</span> · <span>#AzureAD</span></div>
</footer>

<script>
const categories = {
  ps: {
    label: "PowerShell & Windows",
    color: "var(--cyan)",
    catLabel: "PowerShell",
    catBg: "#0d2535",
    catColor: "var(--cyan)"
  },
  linux: {
    label: "Linux & DevOps",
    color: "var(--green)",
    catLabel: "Linux",
    catBg: "#0a2a1a",
    catColor: "var(--green)"
  },
  cloud: {
    label: "Microsoft Cloud & Intune",
    color: "var(--blue)",
    catLabel: "Microsoft Cloud",
    catBg: "#0d1835",
    catColor: "var(--blue)"
  }
};

const files = [
  {
    cat: "ps",
    num: "01",
    emoji: "🪟",
    name: "15 Essential Daily PowerShell Scripts",
    desc: "Server uptime, disk space, CPU/memory, stopped services, event logs, RDP sessions, AD exports, failed logins, and a daily health report — all in one sheet.",
    filename: "powershell-scripts.html",
    accent: "var(--cyan)",
    highlights: ["15 scripts","Copy buttons","Syntax highlighting"]
  },
  {
    cat: "ps",
    num: "02",
    emoji: "🔷",
    name: "Top 15 PowerShell Scripts for Microsoft Intune",
    desc: "Graph API PowerShell scripts covering devices, compliance, configuration profiles, apps, users, Autopilot, groups, CSV export, and licensed user counts.",
    filename: "intune-powershell-scripts.html",
    accent: "var(--purple)",
    highlights: ["15 Graph scripts","Microsoft Graph SDK","Copy buttons"]
  },
  {
    cat: "ps",
    num: "03",
    emoji: "🖥️",
    name: "Daily IT Problems & How to Fix Them Fast",
    desc: "12 common IT issues (Boot Loop, Outlook Crashing, Overheating, RDP, Teams, etc.) with 3-step fixes each, essential commands, and a 10-step daily routine.",
    filename: "daily-it-problems.html",
    accent: "var(--amber)",
    highlights: ["12 problems","Essential commands","Daily routine"]
  },
  {
    cat: "linux",
    num: "04",
    emoji: "🐧",
    name: "Linux Commands for Daily Deployment Work",
    desc: "9 command categories for production deployments — log monitoring, network validation, process management, disk checks, and an incident response flow.",
    filename: "linux-deployment-commands.html",
    accent: "var(--green)",
    highlights: ["9 categories","Copy chips","Incident flow"]
  },
  {
    cat: "linux",
    num: "05",
    emoji: "📋",
    name: "100+ Linux Commands — Complete Cheat Sheet",
    desc: "All 160 commands across 17 sections: File/Dir, Text Processing, Search, Permissions, User Mgmt, Networking, Packages, Services, Cron, Shell, Log Monitoring and more.",
    filename: "linux-100-commands.html",
    accent: "var(--lime)",
    highlights: ["160 commands","17 sections","Live search"]
  },
  {
    cat: "cloud",
    num: "06",
    emoji: "📦",
    name: "Intune Win32 App Deployment",
    desc: "End-to-end Win32 deployment guide: packaging with IntuneWinAppUtil, creating the app, detection rules, assignment types, install process, error codes, and best practices.",
    filename: "intune-win32-deployment.html",
    accent: "var(--sky)",
    highlights: ["11 sections","Error codes","Full flow"]
  },
  {
    cat: "cloud",
    num: "07",
    emoji: "☁️",
    name: "Intune Introduction, Architecture & Ecosystem",
    desc: "Intune fundamentals: what it is, history timeline, Intune vs SCCM comparison, MEM portal, architecture diagram, ecosystem integrations, management scope, and MDM benefits.",
    filename: "intune-intro-architecture-ecosystem.html",
    accent: "var(--blue)",
    highlights: ["Architecture diagram","vs SCCM table","8 sections"]
  },
  {
    cat: "cloud",
    num: "08",
    emoji: "🔷",
    name: "Azure AD (Entra ID) — Complete Overview Part 1",
    desc: "Entra ID fundamentals: core components, identity types, auth methods (FIDO2, MFA), SSO flow, Conditional Access, license tiers (Free/P1/P2), AD Connect hybrid, and bonus terms.",
    filename: "azure-ad-entra-id-overview.html",
    accent: "var(--indigo)",
    highlights: ["10 sections","SSO & CA flows","Bonus terms"]
  },
];

function makeCard(f) {
  const cat = categories[f.cat];
  const card = document.createElement('a');
  card.className = 'file-card';
  card.href = f.filename;
  card.target = '_blank';
  card.style.setProperty('--accent', f.accent);

  const highlights = f.highlights.map(h =>
    `<span style="background:${cat.catBg};color:${cat.catColor};border:1px solid ${cat.catColor}33;font-size:.58rem;font-weight:700;padding:.1rem .4rem;border-radius:4px;">${h}</span>`
  ).join('');

  card.innerHTML = `
    <div class="card-stripe" style="background:${f.accent};"></div>
    <div class="card-inner">
      <div class="card-top">
        <div class="card-emoji">${f.emoji}</div>
        <div class="card-meta">
          <div class="card-num">${f.num} / 08</div>
          <div class="card-name">${f.name}</div>
          <div style="display:flex;gap:.3rem;flex-wrap:wrap;margin-top:.4rem;">${highlights}</div>
        </div>
      </div>
      <div class="card-desc">${f.desc}</div>
    </div>
    <div class="card-footer">
      <span class="filename">${f.filename}</span>
      <button class="open-btn" style="background:${f.accent};">Open →</button>
    </div>`;
  return card;
}

['ps','linux','cloud'].forEach(cat => {
  const grid = document.getElementById('grid-' + cat);
  files.filter(f => f.cat === cat).forEach(f => grid.appendChild(makeCard(f)));
});

// Legend
const legend = document.getElementById('legend');
Object.entries(categories).forEach(([key, cat]) => {
  const div = document.createElement('div');
  div.className = 'legend-item';
  div.innerHTML = `<div class="legend-dot" style="background:${cat.color};"></div><span>${cat.label}</span>`;
  legend.appendChild(div);
});
</script>
</body>
</html>
