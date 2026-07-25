# Plan 001: Make the local add-on bundles installable

> **Executor instructions**: Follow this plan step by step. Run every verification command and confirm the expected result before moving to the next step. If anything in the STOP conditions section occurs, stop and report - do not improvise.
>
> **Drift check (run first)**: `git diff --stat b5c05f2..HEAD -- setup/skills-list.csv setup/setup-global-skills.ps1 setup/SETUP_GUIDE.md`
> If any in-scope file changed since this plan was written, compare the Current state excerpts against the live code before proceeding; on a mismatch, treat it as a STOP condition.

## Status

- **Priority**: P1
- **Effort**: M
- **Risk**: MED
- **Depends on**: none
- **Category**: bug
- **Planned at**: commit `b5c05f2`, 2026-07-23
- **Issue**: not published

## Why this matters

The setup bundle now advertises three local add-ons - `idea-to-design`, `webapp-testing`, and `design-md-library` - as part of the install set, but the install driver still treats every row as a cloneable git repo. That means the `local/*` entries are rewritten into bogus GitHub URLs, so the clean replacements for blocked upstream skills never actually install. Until this is fixed, `using-superpowers` still lacks a working brainstorm replacement and the browser-testing / design-library add-ons are dead weight instead of discoverable skills.

## Current state

The relevant files, each with one line on its role:

- `setup/skills-list.csv` - declares the local add-on rows with the `local/*` convention.
- `setup/setup-global-skills.ps1` - reads each CSV row and always passes `-Repo` to the installer.
- `bin/install-skill.ps1` - already supports `-SourcePath`, but only if the caller uses it.
- `setup/SETUP_GUIDE.md` - documents the local ports as part of the installed bundle.

Current excerpts:

`setup/skills-list.csv`
```text
# webapp-testing: upstream blocked by SkillSpector (HIGH TM1 - shell=True in scripts/with_server.py).
# Ported as a clean methodology-only skill (no bundled scripts) -> local/webapp-testing.
local/webapp-testing|webapp-testing||
# idea-to-design: hand-authored clean port of obra/superpowers brainstorming.
# Upstream blocked by SkillSpector (tool parameter abuse in stop-server.sh visual companion).
# This port removes the browser server entirely; pure process methodology only.
local/idea-to-design|idea-to-design||
# design-md-library: hand-authored wrapper skill (Option B). Indexes the VoltAgent/awesome-design-md
# fork mirror (74 DESIGN.md files, Google Stitch spec). Source lives at ~/dev/upstream/design-md-library/.
local/design-md-library|design-md-library||
```

`setup/setup-global-skills.ps1`
```powershell
foreach ($line in $lines) {
  $parts = $line -split '\|'
  $repo = $parts[0].Trim()
  $name = $parts[1].Trim()
  $relPath = $parts[2].Trim()
  $disabled = $parts[3].Trim() -eq "true"

  $installArgs = @("-Repo", $repo, "-Name", $name)
  if ($relPath) { $installArgs += @("-SkillRelPath", $relPath) }
  if ($disabled) { $installArgs += "-Disabled" }
```

`bin/install-skill.ps1`
```powershell
if ($SourcePath) {
  $skillDir = $SourcePath
} else {
  if (-not $Repo) { Die "Either -Repo or -SourcePath must be provided." }
  if ($Repo -notmatch '^https?://') { $Repo = "https://github.com/$Repo.git" }
```

`setup/SETUP_GUIDE.md`
```text
| brainstorming | Tool parameter abuse in stop-server.sh |

- idea-to-design (clean port of brainstorming - methodology only, no browser server)
- webapp-testing (clean port - methodology only, no bundled scripts; agent writes native Playwright or uses browser MCP tools)
- design-md-library (wrapper that indexes the 74 DESIGN.md files in the awesome-design-md fork mirror)
```

Repo conventions to follow:

- Keep the PowerShell installer loop simple and explicit; the current script already uses a CSV-driven install pipeline, so extend that pipeline instead of introducing a second install path.
- Preserve the existing `install-skill.ps1` contract. It already supports `-SourcePath`; do not add another installer surface unless the local-source mapping truly cannot be expressed in the driver.
- Keep comments short and factual. This repo uses comments to explain install policy, not to narrate implementation history.

## Commands you will need

| Purpose | Command | Expected on success |
|---|---|---|
| Drift check | `git diff --stat b5c05f2..HEAD -- setup/skills-list.csv setup/setup-global-skills.ps1 setup/SETUP_GUIDE.md` | exit 0 and only the planned files, or no output if clean |
| Syntax sanity | `powershell -NoProfile -ExecutionPolicy Bypass -File .\setup\setup-global-skills.ps1 -SkipForks -SkipAudit` | exits 0 after installing the local add-ons |
| Installed add-ons | `Get-ChildItem $env:USERPROFILE\.agents\skills\idea-to-design, $env:USERPROFILE\.agents\skills\webapp-testing, $env:USERPROFILE\.agents\skills\design-md-library` | all three directories exist |
| Scan log | `Select-String -Path $env:USERPROFILE\dev\upstream\SCAN_LOG.md -Pattern 'idea-to-design|webapp-testing|design-md-library'` | one pass row per local add-on |

## Suggested executor toolkit

- No extra agent skills are required. The change is a small installer-driver fix plus docs.

## Scope

**In scope** (the only files you should modify):
- `setup/setup-global-skills.ps1`
- `setup/skills-list.csv`
- `setup/SETUP_GUIDE.md`

**Out of scope** (do NOT touch, even though they look related):
- `bin/install-skill.ps1` - already supports `-SourcePath`; keep the helper contract stable.
- `upstream/idea-to-design/SKILL.md`, `upstream/webapp-testing/SKILL.md`, `upstream/design-md-library/SKILL.md` - source content already exists and should not be rewritten as part of this fix.
- `README.md` - only update it if a later review proves the root README is now lying about the install surface.

## Git workflow

- Branch: follow the repo's existing convention if one is evident; otherwise use a short `fix/` branch for the installer bug.
- Do not push or open a PR unless the operator instructs it.

## Steps

### Step 1: Teach the setup driver to resolve local rows

Update the Phase 4 loop in `setup/setup-global-skills.ps1` so rows whose repo field starts with `local/` are mapped to a `SourcePath` under the repo's `upstream/` directory instead of being passed as `-Repo`.

Implementation shape:

- Derive the local source directory from the skill name, not from GitHub. The current local ports live in `upstream/<skill-name>`.
- Keep the current behavior for all non-`local/` rows.
- Keep `-SkillRelPath` and `-Disabled` behavior unchanged.
- Do not change `install-skill.ps1`; use its existing `-SourcePath` support.

**Verify**: `git diff -- setup/setup-global-skills.ps1` should show only the local-source branch you added, and `powershell -NoProfile -Command "Select-String -Path .\setup\setup-global-skills.ps1 -Pattern 'local/'"` should show the new branch in the driver.

### Step 2: Make the local-source convention explicit in the bundle docs

Update `setup/skills-list.csv` comments and the relevant `setup/SETUP_GUIDE.md` section so the local add-ons are described as intentional local ports, not accidental pseudo-repos.

Use the repo's own vocabulary:

- `idea-to-design` is the clean brainstorming replacement.
- `webapp-testing` is the clean browser-testing replacement.
- `design-md-library` is the wrapper around the local `awesome-design-md` mirror.

**Verify**: `Select-String -Path .\setup\skills-list.csv, .\setup\SETUP_GUIDE.md -Pattern 'local/webapp-testing|local/idea-to-design|local/design-md-library|clean port|wrapper skill'` returns the updated explanatory text.

### Step 3: Run the setup script and confirm the local add-ons land

Run the setup driver once after the code/doc edits and confirm the three local add-ons install successfully.

Check these outputs:

- `idea-to-design... OK`
- `webapp-testing... OK`
- `design-md-library... OK`
- `SCAN_LOG.md` gains one row for each local add-on

**Verify**: `Get-ChildItem $env:USERPROFILE\.agents\skills\idea-to-design, $env:USERPROFILE\.agents\skills\webapp-testing, $env:USERPROFILE\.agents\skills\design-md-library` returns all three paths, and `Select-String -Path $env:USERPROFILE\dev\upstream\SCAN_LOG.md -Pattern 'idea-to-design|webapp-testing|design-md-library'` shows matching rows.

## Test plan

- Add a focused installer smoke check by running `setup-global-skills.ps1` against the local bundle and confirming the three local add-ons land in `~/.agents/skills/` and `~/.claude/skills/`.
- Reuse the existing CSV-driven install pattern; do not invent a separate test harness just for local rows.
- If you need a structural reference, model the change after the current Phase 4 loop in `setup/setup-global-skills.ps1` - it is already the single source of truth for install ordering.

## Done criteria

Machine-checkable. ALL must hold:

- [ ] `setup/setup-global-skills.ps1` installs `local/webapp-testing`, `local/idea-to-design`, and `local/design-md-library` from local source paths instead of GitHub clones.
- [ ] `setup/SETUP_GUIDE.md` explains the local-port convention and the intended replacements.
- [ ] `powershell -NoProfile -ExecutionPolicy Bypass -File .\setup\setup-global-skills.ps1 -SkipForks -SkipAudit` exits 0.
- [ ] `idea-to-design`, `webapp-testing`, and `design-md-library` exist under both `~/.agents/skills/` and `~/.claude/skills/` after install.
- [ ] `~/dev/upstream/SCAN_LOG.md` contains a row for each of the three local add-ons.
- [ ] `git status --short` shows only the intended plan-tracked files, if any.

## STOP conditions

Stop and report back (do not improvise) if:

- Any `local/*` row does not correspond to an `upstream/<skill-name>` source directory.
- The setup driver already contains another local-source mapping branch that this plan did not account for.
- Running the setup script still tries to clone `https://github.com/local/...` after your code changes.
- `skillspector` blocks one of the local ports after the install path fix; that means the source skill itself changed and needs a separate review.

## Maintenance notes

- Future local ports must continue to use the `local/<name>` convention and keep their source in `upstream/<name>` unless this driver is rewritten to use a table.
- Reviewers should look for any future `skills-list.csv` rows that look like pseudo-repos and confirm the driver maps them to a local source path on purpose.
- Do not backslide to GitHub clone URLs for the local ports; that would reintroduce the exact missing-addon failure this plan fixes.