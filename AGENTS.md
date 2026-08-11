# CubeCloud Skills Bundle — Copilot Instructions

## Post-merge workflow

After merging from `origin/main` or installing any new skills batch:
1. Run `bin/full-audit.ps1` and report PASS / FAIL / WARN counts.
2. Verify active skill count in `~/.agents/skills/` against the README badge. If they diverge, flag it before claiming completion.

## Counter verification

After any skill install or removal, the README badge and SETUP_GUIDE counters must match reality. Check:
- `(Get-ChildItem ~/.agents/skills -Directory).Count` vs README badge
- `skills-list.csv` line count vs README claimed total
- If stale, update the counters inline before reporting "done."

## Large install batches (10+ skills)

When installing 10+ skills in one session, start each batch in its own sub-process invocation so a single skill failure doesn't orphan the rest. If the batch exceeds ~20 skills, suggest a fresh chat or `/compact` to avoid context exhaustion mid-batch.
