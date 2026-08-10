# Global Skills and MCP Bundle Install Plan

## Overview
This plan installs and verifies the repository's global VS Code Copilot and skills tooling stack on this Windows machine. It follows the repository's canonical setup pipeline in setup/setup-global-skills.ps1 and then validates the resulting MCP, CLI, skills, and mirror state using the audit scripts in bin/. Tasks are ordered by dependency so each step leaves the machine in a usable, testable state.

## Tasks
### Task 1: Validate prerequisites and shell state (2-4 minutes)
**Files:**
- Read: setup/setup-global-skills.ps1
- Read: setup/SETUP_GUIDE.md
- Read: setup/mcp.json.template

**Step 1: Check required executables and user profile paths**
```powershell
$ErrorActionPreference = "Stop"
$checks = @("python","node","git","winget","powershell")
foreach ($c in $checks) {
  $cmd = Get-Command $c -ErrorAction SilentlyContinue
  if (-not $cmd) { throw "Missing required executable: $c" }
  Write-Host ("{0}: {1}" -f $c, $cmd.Source)
}

Write-Host "USERPROFILE=$env:USERPROFILE"
Write-Host "APPDATA=$env:APPDATA"
Write-Host "TEMP=$env:TEMP"
```

**Step 2: Verify**
Run:
```powershell
python --version
node --version
git --version
```
Expected: each command prints a version string and exits with code 0.

**Step 3: Commit**
```powershell
git add docs/plans/2026-07-21-global-skills-mcp-bundle-plan.md
git commit -m "docs: add global skills and mcp install execution plan"
```

---

### Task 2: Run core global setup pipeline (5 minutes)
**Files:**
- Execute: setup/setup-global-skills.ps1
- Read: setup/skills-list.csv

**Step 1: Execute installer (core stack first, skip fork mirrors)**
```powershell
Set-Location d:\dev\cubecloud-skillsboundle-setup
powershell -NoProfile -ExecutionPolicy Bypass -File .\setup\setup-global-skills.ps1 -SkipForks
```

**Step 2: Verify**
Run:
```powershell
powershell -NoProfile -ExecutionPolicy Bypass -File .\bin\validate-mcp.ps1
```
Expected:
- output contains "JSON valid"
- output lists configured servers including skillspector, firecrawl, scrapling, gbrain, graphify

**Step 3: Commit**
```powershell
git add -A
git commit -m "chore: run core global skills and mcp setup pipeline"
```

---

### Task 3: Run optional fork mirror sync (3-5 minutes)
**Files:**
- Execute: setup/setup-global-skills.ps1

**Step 1: Execute full installer for fork mirrors and reconciliation**
```powershell
Set-Location d:\dev\cubecloud-skillsboundle-setup
powershell -NoProfile -ExecutionPolicy Bypass -File .\setup\setup-global-skills.ps1
```

**Step 2: Verify**
Run:
```powershell
Get-ChildItem "$env:USERPROFILE\dev\forks\JZKK720" -Directory | Measure-Object
```
Expected: Count is greater than 0 and includes cloned fork directories.

**Step 3: Commit**
```powershell
git add -A
git commit -m "chore: sync fork mirrors for global skills bundle"
```

---

### Task 4: Execute repository audit suite (4-5 minutes)
**Files:**
- Execute: bin/full-audit.ps1
- Execute: bin/final-audit.ps1
- Write: upstream/AUDIT_REPORT.md
- Write: upstream/FINAL_AUDIT.md

**Step 1: Run full and final audits**
```powershell
Set-Location d:\dev\cubecloud-skillsboundle-setup
powershell -NoProfile -ExecutionPolicy Bypass -File .\bin\full-audit.ps1
powershell -NoProfile -ExecutionPolicy Bypass -File .\bin\final-audit.ps1
```

**Step 2: Verify**
Run:
```powershell
Get-Content "$env:USERPROFILE\dev\upstream\AUDIT_REPORT.md" -First 30
Get-Content "$env:USERPROFILE\dev\upstream\FINAL_AUDIT.md" -First 30
```
Expected:
- both files exist
- both files begin with audit headings and include PASS/FAIL matrix rows

**Step 3: Commit**
```powershell
git add -A
git commit -m "chore: run full and final global install audits"
```

---

### Task 5: Smoke-test CLI and MCP runtime behavior (3-5 minutes)
**Files:**
- Execute: bin/mcp-smoke-test.ps1
- Execute: bin/check-path.ps1
- Execute: bin/check-mcp-cmds.ps1

**Step 1: Run smoke tests**
```powershell
Set-Location d:\dev\cubecloud-skillsboundle-setup
powershell -NoProfile -ExecutionPolicy Bypass -File .\bin\check-path.ps1
powershell -NoProfile -ExecutionPolicy Bypass -File .\bin\check-mcp-cmds.ps1
powershell -NoProfile -ExecutionPolicy Bypass -File .\bin\mcp-smoke-test.ps1
```

**Step 2: Verify**
Run:
```powershell
Get-Command skillspector,skills-ref,specify,markitdown,scrapling,gbrain,graphify -ErrorAction Stop | Select-Object Name,Source
```
Expected: all listed commands resolve to installed binaries on user PATH.

**Step 3: Commit**
```powershell
git add -A
git commit -m "chore: complete global cli and mcp smoke verification"
```

---

### Task 6: User-facing validation in VS Code Copilot (2-5 minutes)
**Files:**
- Read: %APPDATA%/Code/User/mcp.json
- Read: %APPDATA%/Code/User/settings.json

**Step 1: Validate config files and trigger VS Code reload**
```powershell
Get-Content "$env:APPDATA\Code\User\mcp.json" -Raw | ConvertFrom-Json | Out-Null
Get-Content "$env:APPDATA\Code\User\settings.json" -Raw | Out-Null
Write-Host "Now reload VS Code: Ctrl+Shift+P -> Developer: Reload Window"
```

**Step 2: Verify**
Run in Copilot Chat after reload:
- Type # and confirm MCP tool providers are visible.
- Prompt: use the improve skill to audit this codebase.
Expected: skill invocation and MCP tool availability in chat.

**Step 3: Commit**
```powershell
git add -A
git commit -m "docs: finalize global vscode and copilot validation checklist"
```

---

## Final smoke test coverage
- Global prereq executables present
- Setup pipeline successful with and without fork sync
- VS Code MCP JSON valid and merged
- CLI commands available from user PATH
- Skills installed and mirrored to ~/.claude/skills
- Audit reports generated and readable
- Copilot in-editor skill/tool discovery confirmed
