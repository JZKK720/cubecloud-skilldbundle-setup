---
name: diagram-design
description: >-
  Create branded architecture, IT current-state, flowchart, sequence, state
  machine, ER/data model, timeline, swimlane, quadrant, radar/spider, loop/
  flywheel, nested, tree, org chart, layer stack, Venn, pyramid/funnel, bar,
  line, Gantt, scatter, high-level, process, medallion, data flow, DP
  integration, or DP security matrix diagrams as standalone HTML/SVG/PNG.
  Redraw .drawio/.drawio.png/.drawio.svg or Mermaid .mmd sources at a chosen
  size/detail; onboard brand tokens from a website; add semantic patterns,
  callouts, accessible motion, or sketchy/hand-drawn styling.
license: MIT
metadata:
  version: "1.0"
  source: cathrynlavery/diagram-design (MIT, v2.3)
  port: >-
    Clean methodology-only port. Upstream blocked by SkillSpector (HIGH, 55/100)
    due to 145 HTML example assets flagged as P2 "Hidden Instructions". This port
    retains the full prose methodology, 27-type taxonomy, design system, and
    anti-pattern catalog; HTML assets are referenced from the upstream repo
    rather than bundled. No scripts, no assets, no deps.
  relates: archify, huashu-design, mermaid-diagram-workflow
---

# Diagram Design

Create visual diagrams as self-contained HTML files with inline SVG and CSS, following an opinionated editorial design system.

Twenty-seven visual types. Semantic patterns describe behavior independently; type references describe layout. For the full reference files (type-*.md, style-guide.md, onboarding.md, animation.md, semantic-patterns.md, export.md, import-*.md, primitive-*.md), clone the upstream repo at `https://github.com/cathrynlavery/diagram-design` and read `skills/diagram-design/references/`.

---

## 0. First-time setup — style guide gate

**Before generating your first diagram in a new project, verify the style guide has been customized.**

Don't silently ship default-skinned diagrams into a branded project.

The default tokens are paper `#faf7f2`, ink `#1c1917`, accent `#b5523a` (rust). If they're still the shipped defaults, **pause and ask the user**:

> *"This is your first Schematic in this project. The style guide is still at the default (neutral stone + rust). Do you want to customize it to match your brand first? Options: (a) pull from your website URL, (b) extract from an installed skill, (c) extract from a local folder / design-system directory, (d) paste tokens manually, (e) proceed with the default for now."*

Then branch:
- **(a)** → fetch the site, extract palette + fonts, propose a diff, and write `style-guide.md`.
- **(b)** → ask which skill, read its SKILL.md / CSS / token files, map to semantic roles, propose diff.
- **(c)** → ask for the path, glob for CSS/JSON/MD token files, map to semantic roles, propose diff.
- **(d)** → accept the user's tokens and write them into `style-guide.md` under a "Custom tokens" section.
- **(e)** → proceed; optionally remind the user they can run onboarding later.

**Once the style guide has been customized** (or the user explicitly opted for default), skip this gate on subsequent runs. A simple way to detect customization: if the `accent` value differs from `#b5523a`, assume custom.

---

## 1. Philosophy

**The highest-quality move is usually deletion.**

Applied to schematics:

- Every node represents a distinct idea. Two nodes that always travel together are one node.
- Every connection carries information. If the relationship is obvious from layout, remove the line.
- Coral is **editorial, not a flag.** 1–2 focal nodes per diagram. Using it on 5 nodes erases the signal.
- The schematic isn't done when everything is added. It's done when nothing can be removed.

**Target density: 4/10.** Enough to be technically complete. Not so dense it needs a guide. Above 9 nodes, it's probably two diagrams.

---

## 2. When to Use

Use for any of the 27 visual types (§3) when a reader will learn more from a visual than from prose, a table, or a bulleted list.

**Don't use for:**
- Quick unicode diagrams → use **wiretext**.
- Lists of things → table or bullets.
- Simple before/after → table.
- One-shape "diagrams" → just write the sentence.

Before drawing, ask: *Would the reader learn more from this than from a well-written paragraph?* If no, don't draw.

---

## 3. Selection: semantic pattern, then visual type

When behavior, state, enforcement, or risk carries the meaning, first choose a semantic pattern. Then choose the nearest visual type for layout. If no pattern matches, choose the type directly.

| Behavioral trigger | Semantic pattern → nearest type |
|---|---|
| Fan-in, queue depth, finite capacity, bottleneck | **Fan-in queue / bottleneck** → Data flow |
| Repeated Question / Input / Governance / Output slots across stages | **Stage framework with semantic slots** → Process |
| Conversation or loose input becomes a structured durable artifact | **Unstructured input → structured artifact** → Data flow |
| Two rule traces need pass/fail/skipped/not-reached and first divergence | **Paired policy-evaluation traces** → Flowchart |
| Trust boundaries plus permitted/forbidden ingress or deploy paths | **Secure paved road** → Architecture |
| Controls grouped by where they are enforced | **Governance / control catalog** → Layer stack |
| Defenses compensate for prior gaps and residual risk propagates | **Compensating security layers** → Layer stack |

The pattern owns semantic primitives and its tighter budget; the type owns layout grammar. Use animation only when motion is requested or materially clarifies ordered change; static remains the default.

### Visual-type guide (27)

| If you're showing… | Use | Key layout rule |
|---|---|---|
| Components + connections in a system | **Architecture** | Boxes + labeled arrows, orthogonal routing |
| Legacy IT landscape grouped by phase/department | **IT current-state** | Swimlane-like grouping, documents *before* state |
| Decision logic with branches | **Flowchart** | Oval=start/end, rect=step, diamond=decision, dot=merge |
| Time-ordered messages between actors | **Sequence** | Vertical lifelines, horizontal arrows, activation bars |
| States + transitions + guards | **State machine** | Rounded rects, labeled arrows, [guard] notation |
| Entities + fields + relationships | **ER / data model** | Entity boxes, crow's-foot connectors, field lists |
| Events positioned in time | **Timeline** | Horizontal/vertical axis, event markers, date labels |
| Cross-functional process with handoffs | **Swimlane** | Horizontal/vertical lanes, process steps per role |
| Two-axis positioning / prioritization | **Quadrant** | 2×2 grid, labeled axes, positioned items |
| Multiple entities scored across 3–5 criteria | **Radar / Spider** | Polygonal overlay, labeled axes, legend |
| Reinforcing cycle / flywheel | **Loop** | Circular layout, directional arrows, hub accumulates state |
| Hierarchy through containment / scope | **Nested** | Box-in-box, parent→child containment |
| Parent → children relationships | **Tree** | Root→branches, top-down or left-right |
| Human/agent/team ownership, reporting, routing | **Org chart** | Hierarchical boxes, solid/dashed reporting lines |
| Stacked abstraction levels | **Layer stack** | Horizontal bands, top→bottom dependency |
| Overlap between sets | **Venn** | Overlapping circles, intersection labels |
| Ranked hierarchy or conversion drop-off | **Pyramid / funnel** | Stacked trapezoids, narrowing width |
| Quantitative comparison across categories | **Bar chart** | Vertical/horizontal bars, category axis, value axis |
| Continuous trends over time | **Line chart** | X=time, Y=value, connected data points |
| Tasks and phases on a timeline | **Gantt** | Horizontal bars, phase groupings, dependency arrows |
| Distribution and correlation between two variables | **Scatter plot** | X/Y axes, data points, optional trend line |
| End-to-end data stack on a container cluster | **High-Level** | Platform layers, data flow arrows, infrastructure icons |
| Multi-actor sequential process with data handoffs | **Process** | Left→right flow, actor columns, artifact handoffs |
| Multi-tier data storage with quality levels | **Medallion** | Bronze→Silver→Gold tiers, access policies |
| Role-scoped data flow: who does what at each step | **Data flow** | Actors + data stores + labeled flows |
| Integration topology: sources → core → consumers | **DP integration** | Source systems, core platform, consumer apps |
| Per-role / per-component access permissions matrix | **DP security matrix** | Grid: roles × components, permission indicators |

Rules of thumb:
- If a 3-column table communicates the same thing, pick the table.
- If two types seem useful, pick the dominant axis.
- If you're past the complexity budget (§7), split into an overview + detail.

### Confirm before drawing

Before rendering, state the plan in one short message: the chosen visual type (and semantic pattern, if routed), the size preset, and anything the complexity budget (§7) will force out. If the user is reachable, let them redirect before you draw; if not, proceed and note the assumptions beside the deliverable.

---

## 4. Universal Anti-patterns

These mark "AI slop" schematics of any type:

| Anti-pattern | Why it fails |
|---|---|
| Dark mode + cyan/purple glow | Looks "technical" without design decisions |
| JetBrains Mono as blanket "dev" font | Mono is for *technical* content — ports, commands, URLs. Names go in Geist sans. |
| Identical boxes for every node | Erases hierarchy |
| Legend floating inside the diagram area | Collides with nodes |
| Arrow labels with no masking rect | Bleeds through the line |
| Vertical `writing-mode` text on arrows | Unreadable |
| 3 equal-width summary cards as default | Generic grid — vary widths |
| Shadow on any element | Shadows are out. Borders are in. |
| `rounded-2xl` on boxes | Max radius 6–10px or none |
| Coral on every "important" node | Coral is 1–2 editorial accents, not a signaling system |
| Reproducing Mermaid's renderer layout | Imports automatic spacing instead of making an editorial layout |
| Diagonal / slanted connectors between off-axis nodes | Rounded right-angle (orthogonal) elbows are mandatory |
| Arrow label sitting on or touching its connector | Label must have a 6–10px gap above the line |
| Two connectors overlapping or running on the same path | Each connection must be independently traceable |
| Two connectors sharing a single attach point on a box | Fan attach points along the edge (≥12px apart) |
| Connector routed behind a non-endpoint box without need | Reroute around intervening boxes |

---

## 5. Design System

**The design system is skinnable.** All colors, typography, and tokens live in a single source of truth. The default skin is a cool editorial palette (white-smoke paper, jet-black ink, atomic-tangerine accent, blue-slate muted, silver hairlines); to apply your own brand, either edit the style guide directly or run the URL-based onboarding flow.

### Semantic roles (at a glance)

| Role | Purpose |
|---|---|
| `paper`, `paper-2` | Page bg and container bg |
| `ink` | Primary text / stroke |
| `muted`, `soft` | Secondary text, default arrows, sublabels |
| `rule`, `rule-solid` | Hairline borders |
| `accent`, `accent-tint` | 1–2 focal elements per diagram |
| `link` | HTTP/API calls, external arrows |

**Focal rule:** `accent` goes on 1–2 elements max. Everything else is `ink` / `muted` / `soft`. If you're tempted to accent 4 things, you haven't decided what's focal yet.

### Node type → treatment

| Type | Fill | Stroke |
|---|---|---|
| **Focal** (1–2 max) | `accent-tint` | `accent` |
| **Backend / API / Step** | white | `ink` |
| **Store / State** | `ink @ 0.05` | `muted` |
| **External / Cloud** | `ink @ 0.03` | `ink @ 0.30` |
| **Input / User** | `muted @ 0.10` | `soft` |
| **Optional / Async** | `ink @ 0.02` | `ink @ 0.20` dashed `4,3` |
| **Security / Boundary** | `accent @ 0.05` | `accent @ 0.50` dashed `4,4` |

### Typography

- **Title** — Instrument Serif, 1.75rem, 400 — H1 only
- **Node name** — Geist (sans), 12px, 600 — human-readable labels
- **Sublabel** — Geist Mono, 9px — ports, URLs, field types
- **Eyebrow / tag** — Geist Mono, 7–8px, uppercase, tracked — type tags, axis labels
- **Arrow label** — Geist Mono, 8px — annotation on arrows
- **Editorial aside** — Instrument Serif *italic*, 14px — callouts only

**Mono is for technical content.** Names are Geist sans. Page title is Instrument Serif. Italic Instrument Serif is reserved for annotation callouts. Never JetBrains Mono as a blanket "dev" font.

---

## 6. Mandatory Connector Rules

1. **Orthogonal routing only.** Rounded right-angle elbows. No diagonals, no slanted lines.
2. **Arrow label gap.** 6–10px gap between label and connector line. Masking rect behind label.
3. **No overlapping connectors.** Each connection independently traceable. Bridge crossings or offset parallels.
4. **Fan attach points.** ≥12px apart along the edge. Every arrow clearly distinct.
5. **No routing behind non-endpoint boxes.** Reroute around. Dashed-transit exception only when an unavoidable intervening box sits on the direct path.

---

## 7. Complexity Budget

| Preset | Max nodes | Max connections | Typical use |
|---|---|---|---|
| **Small** | 5 | 6 | Quick architecture, simple flow |
| **Medium** | 9 | 12 | Standard diagram |
| **Large** | 15 | 20 | System overview |
| **X-Large** | 25 | 35 | Full platform topology |

Above 9 nodes, consider splitting into overview + detail. Above 15, split is mandatory unless the user explicitly requests a single diagram.

---

## 8. Output Formats

- **HTML** (default): self-contained, inline SVG + CSS, no external deps
- **SVG**: standalone vector, suitable for embedding
- **PNG**: raster export at 2x resolution

### Export commands

For the full export pipeline (PNG via Playwright, SVG optimization, etc.), clone the upstream repo and read `references/export.md`.

---

## 9. Import from Other Formats

### Mermaid (.mmd)

Parse the Mermaid source, extract the semantic structure (nodes, edges, groups), discard Mermaid's automatic layout, and redraw with editorial layout rules. Do NOT reproduce Mermaid's renderer output.

### Draw.io (.drawio / .drawio.png / .drawio.svg)

Parse the XML, extract cells with their geometry and labels, map to the design system's node treatments, and redraw with orthogonal connectors.

For detailed import procedures, clone the upstream repo and read `references/import-mermaid.md` and `references/import-drawio.md`.

---

## 10. Semantic Primitives

When a semantic pattern is selected, apply these primitives on top of the type's layout grammar:

- **Annotation callout** — Instrument Serif italic, 14px, positioned near the annotated element with a thin rule connector
- **Sketchy / hand-drawn** — slight path jitter (1–2px), uneven stroke weights, optional pencil-texture fill
- **Terminal / code block** — Geist Mono, dark bg, syntax-colored tokens for inline code references
- **Icon set** — 24×24 SVG icons for common concepts (database, server, user, lock, globe, etc.)

For the full primitive reference, clone the upstream repo and read `references/primitive-*.md`.

---

## Attribution

This is a clean methodology-only port of `skills/diagram-design/SKILL.md` from [cathrynlavery/diagram-design](https://github.com/cathrynlavery/diagram-design) (MIT, v2.3). Upstream blocked by SkillSpector (HIGH, 55/100) due to 145 HTML example assets flagged as P2 "Hidden Instructions". This port retains the full prose methodology; HTML assets and detailed reference files are available from the upstream repo. Complements the bundle's `archify`, `huashu-design`, and `mermaid-diagram-workflow` skills.