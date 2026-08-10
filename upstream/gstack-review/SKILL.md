---
name: gstack-review
description: Pre-landing PR review with structural-issue checklist and 8 specialist lenses. Use when asked to review a PR, do a code review, check a diff, or before landing/shipping code changes. Adapted from garrytan/gstack (MIT).
license: MIT
compatibility: requires git repository, intended for PR review workflows
allowed-tools: Read, Grep, Glob, Bash(run:git diff,git log:*), AskUserQuestion
---

# gstack-review — Pre-Landing PR Review

## When to invoke

Use when asked to "review this PR", "code review", "pre-landing review", "check my diff", or when proactively suggesting review before merge. Analyze the diff against the base branch for SQL safety, trust boundary violations, conditional side effects, and other structural issues.

## Workflow

### Step 1: Get the diff

```bash
git diff origin/main...HEAD   # or the target base branch
```

If the user specifies a different base branch, use that instead.

### Step 2: Two-pass review

**Pass 1 (CRITICAL):** SQL & Data Safety, Race Conditions & Concurrency, LLM Output Trust Boundary, Shell Injection, Enum & Value Completeness.

**Pass 2 (INFORMATIONAL):** Async/Sync mixing, column/field name safety, dead code, LLM prompt issues, completeness gaps, time window safety, type coercion at boundaries, view/frontend, CI/CD pipeline.

### Step 3: Output format

```
Pre-Landing Review: N issues (X critical, Y informational)

**AUTO-FIXED:**
- [file:line] Problem → fix applied

**NEEDS INPUT:**
- [file:line] Problem description
  Recommended fix: suggested fix
```

If no issues found: `Pre-Landing Review: No issues found.`

## Review Categories

### Pass 1 — CRITICAL

#### SQL & Data Safety
- String interpolation in SQL
- TOCTOU races: check-then-set patterns that should be atomic
- Bypassing model validations for direct DB writes
- N+1 queries: missing eager loading for associations used in loops/views

#### Race Conditions & Concurrency
- Read-check-write without uniqueness constraint
- find-or-create without unique DB index
- Status transitions not using atomic WHERE/UPDATE
- Unsafe HTML rendering on user-controlled data (XSS)

#### LLM Output Trust Boundary
- LLM-generated values written to DB without format validation
- Structured tool output accepted without type/shape checks
- LLM-generated URLs fetched without allowlist (SSRF risk)
- LLM output stored in vector DBs without sanitization

#### Shell Injection
- `subprocess.run()` with `shell=True` and variable interpolation
- `os.system()` with variable interpolation
- `eval()`/`exec()` on untrusted input

#### Enum & Value Completeness
- New enum/status/tier values: trace every consumer (switches, filters, displays)
- Check allowlists/filter arrays for sibling values
- Verify `case`/`if-elsif` chains handle the new value

### Pass 2 — INFORMATIONAL

#### Async/Sync Mixing
- Sync calls inside `async def` endpoints blocking the event loop
- `time.sleep()` inside async functions

#### Column/Field Name Safety
- Verify ORM column names against schema
- Check `.get()` calls match selected columns

#### Completeness Gaps
- Shortcut implementations where full version costs <30 min
- Missing negative-path or edge-case tests

#### Time Window Safety
- Date-key lookups assuming "today" covers exactly 24h
- Mismatched time windows between related features

#### Type Coercion at Boundaries
- Values crossing language boundaries where types change
- Hash/digest inputs that don't normalize types

#### View/Frontend
- Inline `<style>` blocks in partials
- O(n*m) lookups instead of hash lookups
- Ruby-side filtering that could be DB WHERE clauses

#### CI/CD Pipeline
- Build tool versions matching project requirements
- New artifact types with publish/release workflows
- Version tag format consistency
- Publish step idempotency

## Fix-First Heuristic

- **AUTO-FIX:** Mechanical fixes (missing null checks, wrong column names, obvious N+1 patterns) — apply without asking.
- **ASK:** Ambiguous choices (architecture tradeoffs, API design, scope decisions) — batch into one question.

## Completion Status

- **DONE** — completed with evidence
- **DONE_WITH_CONCERNS** — completed, list concerns
- **BLOCKED** — state blocker and what was tried
- **NEEDS_CONTEXT** — state exactly what info is needed

Be terse. One line per problem, one line per fix. No preamble, no "looks good overall."
