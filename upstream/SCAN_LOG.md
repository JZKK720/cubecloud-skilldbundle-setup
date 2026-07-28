# SkillSpector Scan Log

| Date | Repo | Skill | Verdict | Status | Notes |
|---|---|---|---|---|---|
| 2026-07-19 12:54 | https://github.com/obra/superpowers.git | test-driven-development | pass (exit 0) | active | ref:valid |
| 2026-07-19 12:54 | https://github.com/obra/superpowers.git | systematic-debugging | pass (exit 0) | active | ref:valid |
| 2026-07-19 12:54 | https://github.com/obra/superpowers.git | writing-plans | pass (exit 0) | active | ref:valid |
| 2026-07-19 12:55 | https://github.com/obra/superpowers.git | executing-plans | pass (exit 0) | active | ref:valid |
| 2026-07-19 12:55 | https://github.com/obra/superpowers.git | subagent-driven-development | pass (exit 0) | active | ref:valid |
| 2026-07-19 12:55 | https://github.com/obra/superpowers.git | requesting-code-review | pass (exit 0) | active | ref:valid |
| 2026-07-19 12:55 | https://github.com/obra/superpowers.git | receiving-code-review | pass (exit 0) | active | ref:valid |
| 2026-07-19 12:55 | https://github.com/obra/superpowers.git | using-git-worktrees | pass (exit 0) | active | ref:valid |
| 2026-07-19 12:55 | https://github.com/obra/superpowers.git | finishing-a-development-branch | pass (exit 0) | active | ref:valid |
| 2026-07-19 12:55 | https://github.com/obra/superpowers.git | writing-skills | pass (exit 0) | active | ref:valid |
| 2026-07-19 12:55 | https://github.com/obra/superpowers.git | using-superpowers | pass (exit 0) | active | ref:valid |
| 2026-07-19 12:55 | https://github.com/obra/superpowers.git | dispatching-parallel-agents | pass (exit 0) | active | ref:valid |
| 2026-07-19 12:55 | https://github.com/shadcn/improve.git | improve | pass (exit 0) | active | ref:valid |
| 2026-07-19 12:55 | https://github.com/Forward-Future/loopy.git | loopy | pass (exit 0) | active | ref:valid |
| 2026-07-19 12:55 | https://github.com/DietrichGebert/ponytail.git | ponytail | pass (exit 0) | active | ref:advisory |
| 2026-07-19 12:55 | https://github.com/Nutlope/hallmark.git | hallmark | pass (exit 0) | active | ref:advisory |
| 2026-07-19 12:56 | https://github.com/Leonxlnx/taste-skill.git | taste-skill | pass (exit 0) | active | ref:advisory |
| 2026-07-19 12:56 | https://github.com/JuliusBrussee/caveman.git | caveman | pass (exit 0) | DISABLED | ref:valid |
| 2026-07-19 12:56 | https://github.com/JZKK720/andrej-karpathy-skills.git | karpathy-guidelines | pass (exit 0) | active | ref:valid |
| 2026-07-20 01:09 | JZKK720/oz-skills | mcp-builder | pass (exit 0) | active | ref:valid |
| 2026-07-20 01:09 | JZKK720/oz-skills | analysis-artifacts | pass (exit 0) | active | ref:valid |
| 2026-07-20 01:09 | JZKK720/oz-skills | ci-fix | pass (exit 0) | active | ref:valid |
| 2026-07-20 01:09 | JZKK720/oz-skills | create-pull-request | pass (exit 0) | active | ref:valid |
| 2026-07-20 01:09 | JZKK720/oz-skills | dbt-model-index | pass (exit 0) | active | ref:valid |
| 2026-07-20 01:09 | JZKK720/oz-skills | docs-update | pass (exit 0) | active | ref:valid |
| 2026-07-20 01:09 | JZKK720/oz-skills | github-bug-report-triage | pass (exit 0) | active | ref:valid |
| 2026-07-20 01:09 | JZKK720/oz-skills | github-issue-dedupe | pass (exit 0) | active | ref:valid |
| 2026-07-20 01:09 | JZKK720/oz-skills | scheduler | pass (exit 0) | active | ref:valid |
| 2026-07-20 01:09 | JZKK720/oz-skills | seo-aeo-audit | pass (exit 0) | active | ref:valid |
| 2026-07-20 01:09 | JZKK720/oz-skills | slack-qa-investigate | pass (exit 0) | active | ref:valid |
| 2026-07-20 01:10 | JZKK720/oz-skills | terraform-style-check | pass (exit 0) | active | ref:valid |
| 2026-07-20 01:10 | JZKK720/oz-skills | web-accessibility-audit | pass (exit 0) | active | ref:advisory |
| 2026-07-20 01:10 | JZKK720/oz-skills | web-performance-audit | pass (exit 0) | active | ref:valid |
| 2026-07-20 01:11 | local/design-md-library | design-md-library | pass (exit 0) | active | ref:valid |
| 2026-07-20 01:33 | local/idea-to-design | idea-to-design | pass (exit 0) | active | ref:valid |
| 2026-07-20 01:34 | local/webapp-testing | webapp-testing | pass (exit 0) | active | ref:advisory |

## microsoft/SkillOpt (2026-07-28)

SkillOpt is a text-space skill optimizer (microsoft/SkillOpt, MIT, PyPI v0.2.0) — an engine/CLI, not a methodology SKILL.md. Integrated at the CLI + MCP + scheduler layer (correctly absent from skills-list.csv).

- **CLI install**: `uv tool install --python 3.13 skillopt` ships 3 console scripts (`skillopt-train`, `skillopt-eval`, `skillopt-sleep`). Note: there is NO binary named `skillopt`; the setup script probes `skillopt-eval` for the skip-if-present check (naming bug fixed 2026-07-28).
- **Copilot MCP server**: `plugins/copilot/skillopt/mcp_server.py` (stdio, stdlib-only) exposing `skillopt_list_configs`, `skillopt_train`, `skillopt_eval`. Added to `mcp.json.template` as `skillopt` (MCP count 10 -> 11). Requires `SKILLOPT_REPO` env pointing at the cloned repo (the MCP server shells out to `scripts/train.py` / `scripts/eval_only.py`, which live in the repo, NOT the PyPI wheel).
- **Fork mirror**: `microsoft/SkillOpt` cloned to `~/dev/forks/JZKK720/SkillOpt` in Phase 3 (fork count 30 -> 31). Non-JZKK720 owner, like VoltAgent/awesome-design-md.
- **SkillSpector**: not applicable (SkillOpt is a CLI/engine, not a SKILL.md skill). No scan run.
- **SkillOpt-Sleep**: nightly self-evolution cycle scheduled via `skillopt-sleep schedule --project ~/dev --backend mock --hour 3 --minute 17` in Phase 5c. Installs a Windows Scheduled Task (schtasks) at 03:17 daily. Stages proposals only; adopt is manual.
| 2026-07-20 01:34 | local/webapp-testing | webapp-testing | pass (exit 0) | active | ref:valid |
