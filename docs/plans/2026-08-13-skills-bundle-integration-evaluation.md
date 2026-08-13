# Skills Bundle Integration Evaluation — 2026-08-13

> Evaluation of 10 candidate repos for integration into the CubeCloud Skills Bundle
> (JZKK720/cubecloud-skillsboundle-setup). Continuation of the 2026-08-10 evaluation.
> **Execution complete.** Final state: 153 active + 1 disabled manifest entries, 19 CLIs,
> 11 MCP servers, 39 fork mirrors.

## Execution results (2026-08-13)

| #   | Repo                             | License     | ★     | Verdict                | Actual outcome                                                                                                                      |
| --- | -------------------------------- | ----------- | ----- | ---------------------- | ----------------------------------------------------------------------------------------------------------------------------------- |
| 1   | `ayghri/i-have-adhd`             | —           | —     | ✅ Already in manifest | ✅ Installed (SkillSpector pass, advisory ref)                                                                                      |
| 2   | `miqdadbadjuber/anti-slop`       | MIT         | 172   | ✅ Integrate           | ✅ Hand-ported to `upstream/anti-slop/SKILL.md`, installed (pass)                                                                   |
| 3   | `agentconnect-md/agentconnect`   | Apache-2.0  | 66    | ⏸️ Optional            | ⏸️ Deferred                                                                                                                         |
| 4   | `alexgreensh/attention-span`     | AGPL-3.0    | 353   | ⏸️ Defer               | ⏸️ Deferred (AGPL + output-styles, not SKILL.md)                                                                                    |
| 5   | `firecrawl/pdf-inspector`        | MIT         | 15050 | ✅ Add as CLI          | ✅ Added to Phase 2 pyTools (uv), README CLI table                                                                                  |
| 6   | `cobusgreyling/loop-engineering` | MIT         | —     | ✅ Already integrated  | ✅ Confirmed installed                                                                                                              |
| 7   | `cathrynlavery/diagram-design`   | MIT         | 10647 | ✅ Integrate           | ⚠️ Upstream BLOCKED (HIGH, 55/100 — HTML assets P2). Clean port created at `upstream/diagram-design/SKILL.md`, installed (pass)     |
| 8   | `NanmiCoder/MediaCrawler`        | NOASSERTION | 61995 | ❌ Skip                | ❌ Skipped                                                                                                                          |
| 9   | `virgiliojr94/book-to-skill`     | MIT         | —     | ✅ Already in manifest | ⚠️ Upstream BLOCKED (CRITICAL, 100/100 — Python scripts). Clean port created at `upstream/book-to-skill/SKILL.md`, installed (pass) |
| 10  | `kunchenguid/firstmate`          | MIT         | 3400  | ⏸️ Defer               | ⏸️ Deferred (internal crewmate skills)                                                                                              |

### Key discovery: SkillSpector blocked 2 upstreams

Both `diagram-design` and `book-to-skill` were blocked by the SkillSpector hard gate:

- **diagram-design**: HIGH (55/100) — 145 HTML example assets flagged as P2 "Hidden Instructions"
- **book-to-skill**: CRITICAL (100/100) — bundled Python scripts with subprocess calls, dynamic imports, privilege references

Following the bundle's plan-001 pattern (clean methodology-only ports), both were re-authored:

- **diagram-design**: retained full 27-type taxonomy, design system, anti-pattern catalog, connector rules, complexity budget — HTML assets referenced from upstream repo
- **book-to-skill**: retained full 10-step workflow, 4 modes, chapter generation templates, quality rules — replaced bundled `extract.py` with the bundle's existing `markitdown` CLI

Both clean ports passed SkillSpector (exit 0) and skills-ref (valid).

### Files changed

| File                                                            | Change                                                                                                                                |
| --------------------------------------------------------------- | ------------------------------------------------------------------------------------------------------------------------------------- |
| `setup/skills-list.csv`                                         | +2 new entries (anti-slop, diagram-design); 2 entries converted from upstream clone to `local/*` port (book-to-skill, diagram-design) |
| `setup/setup-global-skills.ps1`                                 | +pdf-inspector to pyTools; fixed Phase 4 local/\* handling to read 5th CSV column                                                     |
| `README.md`                                                     | Updated counters (153 skills, 19 CLIs), added v1.6.0 changelog, added pdf-inspector to CLI table                                      |
| `upstream/anti-slop/SKILL.md`                                   | New — clean port of antislop.md (38 rules, 3 tiers, Liveliness Toolkit, Delivery Gate)                                                |
| `upstream/diagram-design/SKILL.md`                              | New — clean port (27 types, design system, anti-patterns, no assets)                                                                  |
| `upstream/book-to-skill/SKILL.md`                               | New — clean port (10-step workflow, 4 modes, markitdown-based extraction)                                                             |
| `docs/plans/2026-08-13-skills-bundle-integration-evaluation.md` | This file — updated with execution results                                                                                            |

## Repo sync status

- **Local repo** (`d:\dev\cubecloud-skillsboundle-setup`) was behind `origin/main`
  by 1 commit. A local README.md edit was **corrupted mojibake** (em-dashes → `鈥?`,
  table cells space-padded) and blocked fast-forward.
- Action taken: stashed and **dropped** the corrupt README change, fast-forwarded
  `ec5ae29` → `a7125b1` (a7125b1 = `chore: add Python version pinning, AGENTS.md,
safe-update-pass.ps1`).
- **Verified**: `HEAD == origin/main == a7125b1872c9bc8930a0f34fb95d4cc1fb8b697e`,
  working tree clean, `## main...origin/main` (no ahead/behind).
- New files from sync: `AGENTS.md`, `bin/safe-update-pass.ps1`, plus README /
  SETUP_GUIDE / setup-global-skills.ps1 updates.

## Detailed findings

### ✅ Already in manifest (2 repos — but NOT yet installed globally)

- **`ayghri/i-have-adhd`** — entry `ayghri/i-have-adhd|i-have-adhd|.cursor/skills/i-have-adhd|` exists.
  Custom path `.cursor/skills/i-have-adhd`. **Not present in `~/.agents/skills/i-have-adhd/`** —
  manifest not yet executed/audited.
- **`virgiliojr94/book-to-skill`** — entry `virgiliojr94/book-to-skill|book-to-skill||` exists.
  SKILL.md at repo root. Fork mirror `~/dev/forks/JZKK720/book-to-skill/` expected. **Not present**
  in `~/.agents/skills/book-to-skill/` either.
- **Action needed**: run `setup-global-skills.ps1` (or `install-skill.ps1 -SourcePath`) to materialize
  these two, then re-audit so the "active" counter matches reality.

### ✅ Already integrated (1 repo, confirmed installed)

- **`cobusgreyling/loop-engineering`** — 5 skills (`loop-triage`, `minimal-fix`, `loop-constraints`,
  `loop-verifier`, `loop-budget`) verified present in `~/.agents/skills/`. Also a `loop` CLI
  (`npx @cobusgreyling/loop`) in the 18-CLI list. No action.

### ✅ Recommended new integrations (3 repos)

#### 2. miqdadbadjuber/anti-slop (MIT, 172★) — Integrate as `local/` port

- Single file `antislop.md` at repo root: **38 design/copy rules** across 3 tiers
  (Hard Gate / Purpose-Gate / Quality Locks), a Liveliness Toolkit, and a mandatory delivery gate.
- Two usage modes (DURING vs AFTER audit) — maps cleanly to `hallmark` / `taste-skill` / `baseline-ui`
  in the bundle's design category, but is **complementary** (copy + rules tiering, not a design system).
- **Not yet a SKILL.md** — the repo README says an installable skill/plugin ships ~Q3 2026.
- **Recommendation**: hand-port as `local/anti-slop|anti-slop||upstream/anti-slop` using the
  `install-skill.ps1 -SourcePath` convention (plan 001), citing `hallmark` + `baseline-ui` in metadata.
  Revisit when upstream ships the v3.0 SKILL.md.

#### 7. cathrynlavery/diagram-design (MIT, 10.6k★) — Integrate (strong)

- Proper **Copilot-native `skills/diagram-design/SKILL.md`** (36 KB, version 2.3).
- 29 editorial diagram types (architecture, flowchart, sequence, state machine, ER, timeline,
  swimlane, quadrant, radar, Venn, Gantt, medallion, DP security matrix, etc.) as **self-contained
  HTML/SVG/PNG**. Import `.drawio`/Mermaid `.mmd`, brand-token onboarding, semantic patterns, callouts,
  accessible motion, sketchy styling.
- **Differentiation**: this is the _visual artifact_ layer; the bundle's existing `mermaid-diagram-workflow`
  is _rendering_. No direct dedup. Zero Mermaid-slop by design — pairs with `archify` (architecture diagrams)
  and `huashu-design` (bilingual design).
- **Recommendation**: add `cathrynlavery/diagram-design|diagram-design|skills/diagram-design|` +
  fork mirror. Note: has its own ADRs (byte-cap, trigger-rich description) — follow them on port.

#### 5. firecrawl/pdf-inspector (MIT, 15k★) — Add as a CLI, not a skill

- **Rust library/CLI** for PDF classification (TextBased/Scanned/ImageBased/Mixed, ~10-50ms with
  confidence) + position-aware text extraction → clean Markdown, no OCR. Python / Node (napi) / WASM bindings.
- This is a **tool** like `witr` / `markitdown`, not a SKILL.md. The bundle already has `markitdown`
  (PDF→MD) and `firecrawl`; pdf-inspector adds _classification + routing_ (skip OCR for the ~54% that don't need it).
- **Recommendation**: install binary/CLI in Phase 2 (add to 18-CLI list → 19), no skills-list entry.
  Optionally wire as an MCP tool alongside firecrawl.

### ⏸️ Optional / defer (3 repos)

#### 3. agentconnect-md/agentconnect (Apache-2.0, 66★) — Optional

- `.claude/skills/agentconnect-setup/SKILL.md` + `update-model-pricing/SKILL.md`; also `.agents/skills`.
- **Vendor onboarding** skill: guides installing/configuring the self-hosted AgentConnect OSS stack
  (Docker Compose, Logto auth, Cloudflare Tunnel). Useful only if the user runs AgentConnect.
- **Recommendation**: defer. Low standalone value; revisit if AgentConnect becomes a target platform.

#### 4. alexgreensh/attention-span (AGPL-3.0, 353★) — Defer

- **Output styles** (attention-kind, spartan, rundown) for Claude Code — change _how it talks_, not how it codes.
- **Concerns**: (1) AGPL-3.0 conflicts with the bundle's MIT-centric posture; (2) these are `output-styles`,
  not SKILL.md skills; (3) direct overlap with existing `po-caveman` (ultra-compressed prose) and `po-caveman`
  family — "spartan/rundown" ≈ caveman. `attention-kind` is ADHD-friendly (ties to `i-have-adhd`).
- **Recommendation**: defer unless a MIT license / SKILL.md packaging appears. If kept, extract only
  `attention-kind` and fold it into the `i-have-adhd` entry.

#### 10. kunchenguid/firstmate (MIT, 3.4k★) — Defer (heavy cherry-pick needed)

- 19 skills under `.agents/skills/`: afk, ahoy, ask-user-authority, bearings, bootstrap-diagnostics,
  decision-hold-lifecycle, diagnostic-reasoning, firstmate-codexapp, firstmate-coding-guidelines,
  firstmate-orca, fmx-respond, harness-adapters, process-event-sources, project-management,
  quota-array-dispatch, secondmate-provisioning, stow, stuck-crewmate-recovery, updatefirstmate.
- **Most are `metadata.internal: true`** — crewmate/sub-supervisor daemon skills coupled to the firstmate
  runtime (`FM_INJECT_MARK`, `state/.subsuper-*`, quota-array dispatch). Not standalone portable skills.
- **Recommendation**: defer. Revisit only if adopting firstmate as an operator daemon. No clean port path today.

### ❌ Skip (1 repo)

#### 8. NanmiCoder/MediaCrawler (NOASSERTION, 62k★) — Skip

- Popular Chinese social-media crawler (小红书/抖音/快手/B站/微博/贴吧/知乎 posts & comments).
- **Concerns**: (1) license `NOASSERTION` (custom/unclear) — fails the bundle's SkillSpector/license gate;
  (2) it is a **crawling app**, not a SKILL.md or portable tool; (3) heavy platform-specific deps, anti-bot
  evasion (CDP), and ToS-sensitive scraping that does not fit an agent-skills bundle.
- **Recommendation**: skip. The bundle's `scrapling`/`wigolo` cover general retrieval.

## Execution checklist (when approved)

1. **Materialize missing** — run `setup-global-skills.ps1` to install `i-have-adhd` + `book-to-skill`,
   then re-run audit to reconcile the 151-active counter.
2. **anti-slop** — create `local/anti-slop` port (copy `antislop.md` → `SKILL.md` + frontmatter),
   add `local/anti-slop|anti-slop||upstream/anti-slop` to skills-list.csv, run SkillSpector gate.
3. **diagram-design** — add `cathrynlavery/diagram-design|diagram-design|skills/diagram-design|` +
   fork mirror + `sync-fork-upstreams.ps1` mapping (`"diagram-design" = "cathrynlavery/diagram-design"`).
4. **pdf-inspector** — add install to Phase 2 CLI list (bump 18 → 19); optionally MCP wiring.
5. **Fork sync** — add mappings for `anti-slop`, `diagram-design` to `bin/sync-fork-upstreams.ps1`.
6. **Counters** — update README + SETUP_GUIDE skill/CLI/fork counts after all changes land.
