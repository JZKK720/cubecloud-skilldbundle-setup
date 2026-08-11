# 🧊 CubeCloud Skills Bundle

> One-command setup for a full **VS Code Copilot Chat** agent-skills stack on Windows — 144 skills, 18 CLIs, 11 MCP servers, and a 74-site design-system library, all security-gated.

[![Skills](https://img.shields.io/badge/skills-144-2ea44f)](#whats-included)
[![CLIs](https://img.shields.io/badge/CLIs-18-blue)](#clis-installed)
[![MCP servers](https://img.shields.io/badge/MCP%20servers-11-purple)](#mcp-servers)
[![Security gate](https://img.shields.io/badge/security%20gate-SkillSpector-green)](#security-model)
[![Platform](https://img.shields.io/badge/platform-Windows-0078D4)](#prerequisites)
[![Version](https://img.shields.io/badge/version-1.5.0-orange)](#changelog)
[![License](https://img.shields.io/badge/license-MIT-success)](LICENSE)

---

## Why this exists

VS Code Copilot Chat gets dramatically more powerful when you give it **skills** — markdown instruction packs that teach it domain-specific workflows (TDD, systematic debugging, design systems, Azure patterns, PR review). But assembling a trustworthy stack by hand is painful: you have to find skills, vet them for safety, wire up the MCP servers, install the CLIs, and repeat on every machine.

**CubeCloud Skills Bundle** does all of it in one command. Every skill passes through [NVIDIA SkillSpector](https://github.com/NVIDIA/skillspector) before landing on your machine — vulnerable skills are blocked by design, not after the fact.

## What you get

|                    | Count   | What                                                                                                                                                                                                                                                                                                                                                                                            |
| ------------------ | ------- | ----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------- |
| 🧠 Skills          | **144** | Discovered by Copilot Chat — superpowers methodology, ui-skills, agent-skills, ECC agent engineering, Azure patterns, design systems, code review, debugging, archify diagrams, huashu-design, and more                                                                                                                                                                                         |
| 🔧 CLIs            | **18**  | On PATH: `skillspector`, `skills-ref`, `specify`, `agent-reach`, `graphify`, `markitdown`, `gbrain`, `scrapling`, `uipro`, `firecrawl`, `skillopt-eval`, `headroom`, `loop`, `watch-skill`, `wigolo`, `ocr`, `semantica`, `witr`                                                                                                                                                                |
| 🔌 MCP servers     | **11**  | Configured in VS Code `mcp.json`: markitdown, skillspector, firecrawl, scrapling, gbrain, graphify, headroom, loop-engineering, watch-skill, wigolo, skillopt                                                                                                                                                                                                                                   |
| 📚 Fork mirrors    | **39**  | Read-only backups in `~/dev/forks/JZKK720/`, including VoltAgent/awesome-design-md, microsoft/SkillOpt, alibaba/open-code-review, EveryInc/compound-engineering-plugin, Shubhamsaboo/awesome-llm-apps, cobusgreyling/loop-engineering, oxbshw/watch-skill, KnockOutEZ/wigolo, tt-a1i/archify, virgiliojr94/book-to-skill, alchaincyf/huashu-design, semantica-agi/semantica, pranshuparmar/witr |
| 🎨 DESIGN.md files | **74**  | Real-world design systems (Apple, Stripe, Linear, Vercel, Notion, Airbnb, Tesla…) indexed by the `design-md-library` skill                                                                                                                                                                                                                                                                      |
| 🔒 Security-gated  | **yes** | Every skill scanned by SkillSpector before install; 5 skills blocked by design                                                                                                                                                                                                                                                                                                                  |

## Architecture

```mermaid
graph TB
    subgraph L4["LAYER 4 — Project Bootstrap"]
        SPEC["specify init --integration copilot"]
        AGENTS["10 .agent.md commands"]
        TEMPLATES[".specify/ template tree"]
        SPEC --> AGENTS
        SPEC --> TEMPLATES
    end

    subgraph L3["LAYER 3 — Agent Commands (per-project)"]
        SD["/speckit.specify → /speckit.plan → /speckit.tasks"]
        IM["/speckit.implement → /speckit.converge"]
        EXT["extensions · presets · bundles"]
    end

    subgraph L2["LAYER 2 — Skills (117 core, 26 Azure)"]
        direction LR
        METH["superpowers (12)"] --> COPILOT["VS Code Copilot Chat"]
        DSN["design systems (74)"] --> COPILOT
        REV["code review (6)"] --> COPILOT
        DBG["debugging (4)"] --> COPILOT
        LOOP["loop engineering (5)"] --> COPILOT
        AZURE["Azure/cloud (26)"] --> COPILOT
        CRAFT["crafted (16)"] --> COPILOT
    end

    subgraph L1["LAYER 1 — CLIs + MCP Servers"]
        direction LR
        CLI["16 CLIs on PATH"] --> MCP["11 MCP servers"]
        MCP --> VSCODE["VS Code mcp.json"]
    end

    subgraph L0["LAYER 0 — Design Systems"]
        D74["74 DESIGN.md files"] --> LIB["design-md-library skill"]
    end

    L4 --> L3
    L3 --> L2
    L2 --> L1
    L1 --> L0

    style L4 fill:#1a3a2a,stroke:#4caf50,color:#e0ffe0
    style L3 fill:#1a2a3a,stroke:#2196f3,color:#e0f0ff
    style L2 fill:#2a1a3a,stroke:#9c27b0,color:#f0e0ff
    style L1 fill:#3a3a1a,stroke:#ff9800,color:#fff0e0
    style L0 fill:#3a1a1a,stroke:#f44336,color:#ffe0e0
```

> **Layer 4** is where [spec-kit](https://github.com/github/spec-kit) lives — the only component that bridges "new project idea" → "structured, agent-ready project." Without it, every project starts as a blank prompt. With `specify init`, Copilot gets 10 native workflow commands, an SDD template stack, and an extension ecosystem.

## Quick start

```powershell
git clone https://github.com/JZKK720/cubecloud-skilldbundle-setup.git ~/dev/setup
powershell -NoProfile -ExecutionPolicy Bypass -File ~/dev/setup/setup-global-skills.ps1
```

Then **restart VS Code**, open Copilot Chat, and type `#` to see your MCP tools appear.

**Total time: ~15 minutes** (or ~10 min with `-SkipForks`).

### Prerequisites

The script checks for and (where possible) installs these. Pre-install on a fresh machine:

```powershell
winget install Python.Python.3.13
winget install OpenJS.NodeJS
winget install Git.Git
winget install Microsoft.VisualStudioCode
```

## What's included

### Skills (142 active, 1 disabled, 5 blocked — 2 with clean ports)

**Superpowers methodology (12 skills)** from [obra/superpowers](https://github.com/obra/superpowers):
test-driven-development · systematic-debugging · writing-plans · executing-plans · subagent-driven-development · requesting-code-review · receiving-code-review · using-git-worktrees · finishing-a-development-branch · writing-skills · using-superpowers · dispatching-parallel-agents

**ECC agent engineering (35 skills)** from [evan-ai/ECC](https://github.com/evan-ai/ECC) — curated from 278, framework-agnostic only:
safety-guard · token-budget-advisor · intent-driven-development · verification-loop · eval-harness · agent-self-evaluation · prompt-optimizer · rules-distill · knowledge-ops · codebase-onboarding · repo-scan · code-tour · search-first · blueprint · strategic-compact · enterprise-agent-ops · production-audit · error-handling · delivery-gate · coding-standards · context-budget · security-review · security-scan · security-bounty-hunter · brand-discovery · brand-voice · frontend-design-direction · make-interfaces-feel-better · continuous-agent-loop · cost-tracking · cost-aware-llm-pipeline · automation-audit-ops · connections-optimizer · mcp-server-patterns · backend-patterns

**oz-skills (14 active)** from the JZKK720 fork mirror:
analysis-artifacts · ci-fix · create-pull-request · dbt-model-index · docs-update · github-bug-report-triage · github-issue-dedupe · mcp-builder · scheduler · seo-aeo-audit · slack-qa-investigate · terraform-style-check · web-accessibility-audit · web-performance-audit

**ui-skills (7 active)** from [ibelick/ui-skills](https://github.com/ibelick/ui-skills):
ui-skills-root · baseline-ui · create-design-md · fixing-accessibility · fixing-metadata · fixing-motion-performance · improve-ui

**agent-skills (23 active, unique entries)** from [addyosmani/agent-skills](https://github.com/addyosmani/agent-skills):
api-and-interface-design · browser-testing-with-devtools · ci-cd-and-automation · code-review-and-quality · code-simplification · context-engineering · debugging-and-error-recovery · deprecation-and-migration · documentation-and-adrs · doubt-driven-development · frontend-ui-engineering · git-workflow-and-versioning · idea-refine · incremental-implementation · interview-me · observability-and-instrumentation · performance-optimization · planning-and-task-breakdown · security-and-hardening · shipping-and-launch · source-driven-development · spec-driven-development · using-agent-skills

**Azure & cloud (27 skills)** — bundled with VS Code Azure extensions, discovered automatically:
ai-mlstudio · airunway-aks-setup · appinsights-instrumentation · azure-ai · azure-aigateway · azure-cloud-migrate · azure-compliance · azure-compute · azure-cost · azure-deploy · azure-diagnostics · azure-enterprise-infra-planner · azure-kubernetes · azure-kusto · azure-messaging · azure-prepare · azure-quotas · azure-reliability · azure-resource-lookup · azure-resource-visualizer · azure-storage · azure-upgrade · azure-validate · entra-agent-id · entra-app-registration · microsoft-foundry · python-appservice-deploy

These Azure/Foundry entries are standard extension-provided skills, not custom bundle ports.

**Crafted individual skills:**

- **self-learning** — capture hard-won workflows as reusable skills
- **improve** — audit a codebase into prioritized implementation plans
- **loopy** — discover, run, and publish repeatable agent loops
- **loop-engineering** — design, scaffold, audit, and operate agent loop infrastructure (scheduling, isolation, scoring, governance). Complements loopy (loop content) with loop infrastructure.
- **watch-skill** — video intelligence for agents: watch, remember, verify. 23 MCP tools for video analysis, transcription, OCR, and THE LOOP (browser/UI verification).
- **wigolo** — local-first web intelligence: search, fetch, crawl, extract, research. 10 MCP tools, no API keys needed for core tools. Complements firecrawl (paid) with a free local alternative.
- **ponytail** — force the laziest solution that actually works (YAGNI)
- **hallmark** — anti-slop UI design for landing pages and redesigns
- **taste-skill** — frontend taste/polish, anti-templated output
- **karpathy-guidelines** — coding behavioral guidelines
- **agent-reach** — research across 15 platforms (Twitter, Reddit, YouTube, GitHub, LinkedIn, Xueqiu, Bilibili, XiaoHongShu, and more)
- **graphify** — turn any folder into a knowledge graph
- **browser-harness** — full CDP browser automation (navigate, extract, interact)
- **loop-engineering (5 skills)** — agent self-management: triage, constraints, budget, verification, minimal-fix
- **ARIS ports (3 skills)** — academic research workflow: literature search, novelty check, idea generation
- **changelog-generator** — auto-generate user-facing changelogs from git history

Custom implementations maintained in this setup are `agent-reach` and `gstack-review`.

**Hand-ported:**

- **gstack-review** — pre-landing PR review with structural-issue checklist + 8 specialist lenses (security, testing, maintainability, performance, data-migration, api-contract, red-team). Adapted from [garrytan/gstack](https://github.com/garrytan/gstack) (MIT).
- **design-md-library** — indexes the 74 DESIGN.md files in the awesome-design-md fork mirror so agents can self-serve "make it look like Stripe" requests
- **idea-to-design** — clean port of obra/superpowers `brainstorming` (upstream blocked by SkillSpector for tool parameter abuse in `stop-server.sh`). Methodology only: collaborative design dialogue, hard gate before implementation, spec self-review, user review gate. No browser server, no scripts.
- **webapp-testing** — clean port of JZKK720/oz-skills `webapp-testing` (upstream blocked by SkillSpector for `shell=True` tool parameter abuse in `scripts/with_server.py`). Methodology only: reconnaissance-then-action pattern, static vs dynamic decision tree. No bundled scripts; agent writes native Playwright or uses browser MCP tools.

**Disabled by default:**

- **caveman** — token compression, opt-in only

**Blocked by SkillSpector (not installed — by design):**

| Skill                      | Reason                                                                        | Clean port?                             |
| -------------------------- | ----------------------------------------------------------------------------- | --------------------------------------- |
| brainstorming              | Tool parameter abuse in `stop-server.sh`                                      | **Yes** → `idea-to-design`              |
| last30days                 | Info stealer (reads browser cookies)                                          | No — use `agent-reach`                  |
| ui-ux-pro-max              | Prompt extraction + unsafe defaults                                           | No — use `hallmark` + `taste-skill`     |
| anysearch                  | Vulnerable `requests==2.20` (8 CVEs)                                          | No                                      |
| webapp-testing (oz-skills) | HIGH TM1 — tool parameter abuse (`shell=True` in `scripts/with_server.py:69`) | **Yes** → `webapp-testing` (clean port) |

### CLIs installed

| Tool            | Source | Purpose                                                                                                                                                                                                                                                                                                |
| --------------- | ------ | ------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------ | ------ | ------------------------------------------------------------------------------------------------------------------------------ | --------------------------------------------------------------------------------------- | ----------------------------------------------------------------------------------------------------- |
| `skillspector`  | uv     | Security scanner — hard gate for every skill install                                                                                                                                                                                                                                                   |
| `skills-ref`    | uv     | Spec validator (advisory)                                                                                                                                                                                                                                                                              |
| `specify`       | uv     | Spec-Driven Development CLI — `specify init` bootstraps a project with 10 Copilot-native `.agent.md` workflow commands (specify → plan → tasks → implement → converge), a 4-layer template resolution stack, and community extensions/presets/bundles. Pairs with the `spec-driven-development` skill. |
| `skillopt-eval` | uv     | Skill evaluation harness                                                                                                                                                                                                                                                                               |
| `agent-reach`   | uv     | 15-platform research access                                                                                                                                                                                                                                                                            |
| `graphify`      | uv     | Folder → knowledge graph                                                                                                                                                                                                                                                                               |
| `markitdown`    | uv     | Convert anything to Markdown                                                                                                                                                                                                                                                                           |
| `scrapling`     | uv     | Stealthy web scraping                                                                                                                                                                                                                                                                                  |
| `uipro`         | npm    | UI/UX workflow CLI                                                                                                                                                                                                                                                                                     |
| `firecrawl`     | npm    | Firecrawl API CLI                                                                                                                                                                                                                                                                                      |
| `gbrain`        | bun    | Persistent agent memory                                                                                                                                                                                                                                                                                |
| `headroom`      | uv     | Context compression layer for AI agents (60-95% fewer tokens); MCP server exposes `headroom_compress`, `headroom_retrieve`, `headroom_stats`. Requires Defender exclusion for `ast-grep-cli` — see [Platform limitations](#platform-limitations-windows).                                              |
| `loop`          | npm    | Loop engineering CLI front door — `npx @cobusgreyling/loop init                                                                                                                                                                                                                                        | doctor | status                                                                                                                         | audit                                                                                   | cost`. Scaffolds agent loops (daily triage, PR babysitter, CI sweeper, etc.) with Loop Ready scoring. |
| `watch-skill`   | uv     | Video intelligence CLI — `watch-skill watch                                                                                                                                                                                                                                                            | ask    | search                                                                                                                         | serve`. 23 MCP tools for video analysis, transcription, OCR, and THE LOOP verification. |
| `wigolo`        | npm    | Local-first web intelligence — `npx wigolo`. 10 MCP tools for search, fetch, crawl, extract, research. No API keys needed for core tools.                                                                                                                                                              |
| `ocr`           | npm    | AI-powered code review CLI — `ocr review                                                                                                                                                                                                                                                               | scan   | delegate`. Deterministic + agent hybrid architecture (alibaba/open-code-review, Apache-2.0). Battle-tested at Alibaba's scale. |

### MCP servers

Configured in VS Code User `mcp.json`:

- **markitdown** — convert anything to Markdown
- **skillspector** — skill security scanning
- **firecrawl** — web scraping/crawling
- **scrapling** — stealthy fetching
- **gbrain** — persistent memory
- **graphify** — codebase knowledge graphs
- **headroom** — context compression (`headroom_compress`, `headroom_retrieve`, `headroom_stats`)
- **loop-engineering** — loop pattern lookup, skills, state (`@cobusgreyling/loop-mcp-server`)
- **watch-skill** — video analysis, transcription, OCR, THE LOOP verification (`watch-skill serve`)
- **wigolo** — local-first web search, fetch, crawl, research (`npx wigolo`)
- **skillopt** — SkillOpt research engine: validation-gated skill optimization via MCP tools `skillopt_list_configs`, `skillopt_train`, `skillopt_eval` (microsoft/SkillOpt, MIT). Shells out to the repo's `scripts/train.py` / `eval_only.py` — requires the SkillOpt fork mirror.

### OpenCodeReview (AI code review)

The bundle includes the **`ocr` CLI** (`@alibaba-group/open-code-review`, Apache-2.0) — a deterministic + agent hybrid code review engine battle-tested at Alibaba's scale. Two skills ship with it:

- **`open-code-review`** — invokes `ocr review` with the right flags, prerequisite checks, and a comment-triage rubric (High/Medium/Low). Requires a configured LLM.
- **`open-code-review-delegate`** — delegation mode: the host agent drives the review using its own LLM; OCR handles only deterministic file selection and rule resolution. **No OCR-side LLM needed.**

```powershell
ocr review --audience agent -b "context"           # review working copy
ocr review --audience agent -b "context" --from main --to feature  # branch range
ocr review --preview                                # dry-run (no LLM cost)
ocr delegate preview                                # delegation mode preview
```

### SkillOpt-Sleep (nightly self-evolution)

The setup also schedules **SkillOpt-Sleep** — a nightly offline cycle that harvests past session transcripts, mines recurring tasks, replays them, and stages a validated skill edit for review (adopt is manual by design). Installed as a Windows Scheduled Task (`schtasks`) at 03:17 daily via `skillopt-sleep schedule --project ~/dev --backend mock`. The `mock` backend spends no model budget; re-schedule with `--backend claude` or `--backend copilot` once credentials are configured:

```powershell
skillopt-sleep status      # show state + latest staged proposal
skillopt-sleep adopt       # apply the latest staged proposal (with backup)
skillopt-sleep unschedule --all   # remove the nightly task
skillopt-sleep schedule --project ~/dev --backend claude --hour 3 --minute 17
```

Logs land in `~/dev/.skillopt-sleep/cron.log`. Sleep only STAGES proposals — no skill changes until you run `adopt`.

## Security model

Every skill is scanned by **NVIDIA SkillSpector** before install:

```powershell
skillspector scan --no-llm <dir>
```

- Exit 0 → safe → install proceeds
- Exit 1 → `do_not_install` → **HARD BLOCK**, skill is not installed
- Exit 2 → error → investigate before retrying

`skills-ref validate` runs as an **advisory** check (logs spec drift, doesn't block).

Full verdict history is in [`upstream/SCAN_LOG.md`](upstream/SCAN_LOG.md).

## Repository layout

```
~/dev/
├── setup/                      # the one-command installer + config
│   ├── setup-global-skills.ps1 # master installer
│   ├── install-skill.ps1       # security-gated skill install helper
│   ├── skills-list.csv         # manifest of 144 entries (143 active + 1 disabled)
│   ├── mcp.json.template       # 11 MCP server config
│   └── SETUP_GUIDE.md          # detailed guide
├── bin/                        # 17 audit/fix/install helper scripts
├── upstream/                   # governance docs + design-md-library wrapper skill
└── forks/JZKK720/              # 39 read-only fork mirrors (gitignored, re-cloned)
```

## How to use after setup

In Copilot Chat, try:

- _"use the **improve** skill to audit this codebase"_
- _"use **systematic-debugging** to investigate this error"_
- _"use the **design-md-library** to build me a page that looks like Stripe"_
- _"use **gstack-review** to review my PR"_
- _"use **agent-reach** to research what people are saying about X on Reddit"_
- _"use `specify init my-app --integration copilot` to scaffold a new SDD project"_
- _"then `/speckit.specify Build a photo organizer with album grouping and drag-and-drop`"_
- _"use **loop-engineering** to set up automated daily triage on this repo"_
- _"use **watch-skill** to analyze this meeting recording"_
- _"use **wigolo** to research what's new in React 19"_

## To update later

```powershell
# Re-run the installer (skips already-installed items)
powershell -NoProfile -ExecutionPolicy Bypass -File ~/dev/setup/setup-global-skills.ps1

# Update tools
uv tool upgrade --all
npm update -g
bun pm -g update

# Re-scan all skills quarterly
skillspector scan ~/.agents/skills/ --recursive --no-llm
```

## To add a new skill

```powershell
cd ~/dev/bin
.\install-skill.ps1 -Repo "owner/repo" -Name "skill-name"
# Disabled:
.\install-skill.ps1 -Repo "owner/repo" -Name "skill-name" -Disabled
# Custom path:
.\install-skill.ps1 -Repo "owner/repo" -Name "skill-name" -SkillRelPath "path/to/skill"
```

## Platform limitations (Windows)

| Tool     | Issue                                                                      | Workaround                                                                                                                                                  |
| -------- | -------------------------------------------------------------------------- | ----------------------------------------------------------------------------------------------------------------------------------------------------------- |
| EverOS   | `import fcntl` (Unix-only)                                                 | Not installed. `gbrain` MCP used instead.                                                                                                                   |
| headroom | Windows Defender blocks `ast-grep-cli.exe` (false positive on Rust binary) | Run `bin/add-defender-exclusion-ast-grep.ps1` in an elevated PowerShell, then `uv tool install "headroom-ai[proxy]"`. Exclusion is scoped to ast-grep only. |
| recall   | Needs Claude Code hooks                                                    | Claude Code only; not for VS Code Copilot.                                                                                                                  |

## Changelog

### v1.5.0 (2026-08-11)

**144 skills · 18 CLIs · 11 MCP servers · 39 fork mirrors · 172 active total**

- **+5 skills**: archify, book-to-skill, huashu-design, scope-creep-detector, dependency-doctor, project-graveyard (awesome-llm-apps set)
- **+2 CLIs**: `semantica` (uv tool, v0.6.0), `witr` (GitHub release binary, v0.3.3 — no Go needed)
- **+3 fork mirrors**: alchaincyf/huashu-design, semantica-agi/semantica, pranshuparmar/witr
- **Phase 2**: automatic `witr` release-binary download added (no Go toolchain required)
- **Bug fixes**: removed 4 dead `local/*` placeholder entries from skills-list.csv; fixed local/* handling in Phase 4
- **25 compound-engineering skills** integrated (blocked by SkillSpector risk 81/100 — available as fork mirror)

### v1.4.0 (2026-07-15)

**139 skills · 16 CLIs · 10 MCP servers · 36 fork mirrors**

- +35 ECC skills (agent engineering, codebase intelligence, development governance, security, design/UI, operations/cost, engineering practices)

### v1.3.0 and earlier

See `git tag --list` for older releases.

## License
