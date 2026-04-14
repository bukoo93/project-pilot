# Project Pilot

**Project Pilot** is a Claude Code plugin that gives Project Managers and Developers a complete suite of codebase intelligence tools. It works in **any git repository**, regardless of language or framework.

> Zero external dependencies. No MCP servers required. Just git and Claude Code.

---

## Installation

```
/plugin install project-pilot
```

Or browse: `/plugin` > **Discover** > search "project-pilot"

## How It Works

Project Pilot offers **two ways to use every feature**:

### 1. Natural Language (Keywords)

Just ask in plain English or Korean. Claude automatically detects what you need:

```
"프로젝트 분석해줘"              → Project Analysis
"이 코드 왜 이렇게 짰어?"       → Code History
"기술 부채 확인해줘"             → Technical Debt
"릴리즈 노트 만들어줘"           → Release Notes
"이거 바꾸면 뭐가 깨져?"        → Impact Analysis
"스프린트 어때?"                → Sprint Health
"프로젝트 대시보드 보여줘"       → PM Dashboard
```

```
"what technologies does this project use?"  → Project Analysis
"why was this code written this way?"       → Code History
"show me the technical debt"                → Technical Debt
"generate release notes"                    → Release Notes
"what breaks if I change this?"             → Impact Analysis
"how is the sprint going?"                  → Sprint Health
"project health dashboard"                  → PM Dashboard
```

### 2. Slash Commands (Power User)

For precise control with options:

```
/project-pilot:analyze stack --lang ko
/project-pilot:debt --threshold high
/project-pilot:release-notes v2.0.0 --format narrative
/project-pilot:impact src/auth/login.ts --depth 3
```

---

## Features

### For Project Managers

| Feature | Keyword Triggers | Slash Command |
|---------|-----------------|---------------|
| **Project Dashboard** | "프로젝트 대시보드", "project health" | `/project-pilot:dashboard` |
| **Sprint Health** | "스프린트 어때", "velocity" | `/project-pilot:sprint-health` |
| **Technical Debt** | "기술 부채", "code quality" | `/project-pilot:debt` |
| **Release Notes** | "릴리즈 노트", "changelog" | `/project-pilot:release-notes` |
| **Bus Factor** | "버스 팩터", "knowledge risk" | `/project-pilot:bus-factor` |
| **Onboarding Guide** | "온보딩 가이드", "new member guide" | `/project-pilot:onboard` |

### For Developers

| Feature | Keyword Triggers | Slash Command |
|---------|-----------------|---------------|
| **Project Analysis** | "프로젝트 분석", "tech stack" | `/project-pilot:analyze` |
| **Code History** | "왜 이렇게 짰어", "code history" | `/project-pilot:history` |
| **Impact Analysis** | "영향도 분석", "what breaks" | `/project-pilot:impact` |
| **Dependency Analysis** | "의존성 분석", "circular deps" | `/project-pilot:deps` |
| **Breaking Changes** | "브레이킹 체인지", "what changed" | `/project-pilot:breaking-changes` |
| **ADR Generator** | "ADR 작성", "decision record" | `/project-pilot:adr` |

---

## Feature Details

### Project Analysis

Analyze your project's tech stack, architecture, and business domain in one command.

```
/project-pilot:analyze                    # Full analysis (stack + structure + logic)
/project-pilot:analyze stack              # Tech stack only
/project-pilot:analyze structure          # Architecture pattern only
/project-pilot:analyze logic              # Business domain only
/project-pilot:analyze --lang ko          # Korean output
```

**Output includes:** Language/framework detection, architectural pattern identification (MVC, hexagonal, layered, etc.), directory purpose mapping, domain model, API surface, key workflows.

---

### Code History

Understand **why** code was written a certain way — not just what it does.

```
/project-pilot:history src/auth/login.ts              # File history
/project-pilot:history processPayment                  # Function history
/project-pilot:history src/auth/login.ts --depth deep  # Full history with PRs
```

Uses `git log`, `git blame -w -C -C -C`, and PR references to reconstruct the **decision narrative** behind code changes.

---

### Technical Debt Report

Scan for complexity hotspots, stale TODOs, outdated dependencies, and code smells.

```
/project-pilot:debt                              # Full scan, medium threshold
/project-pilot:debt src --threshold high         # Critical items only
/project-pilot:debt --threshold low --lang ko    # All items, Korean
```

Each finding gets a **risk score (1-10)** based on: Severity x Likelihood x Age x Centrality. PM-friendly categories: `[CRITICAL]` `[HIGH]` `[MEDIUM]` `[LOW]`.

---

### Release Notes

Auto-generate categorized release notes from git history.

```
/project-pilot:release-notes                        # Since last tag
/project-pilot:release-notes v1.2.0                 # Since specific tag
/project-pilot:release-notes --format narrative      # For stakeholders
/project-pilot:release-notes --format bullet         # Simple list
/project-pilot:release-notes --include-breaking      # Include breaking changes
```

Supports conventional commits (`feat:`, `fix:`, `refactor:`) and auto-categorizes non-conventional messages.

---

### ADR Generator

Create Architecture Decision Records from code changes or a specific topic.

```
/project-pilot:adr auto                                # Auto-detect from recent changes
/project-pilot:adr "switch from REST to GraphQL"       # Specific topic
/project-pilot:adr auto --since 30d                    # Look at last 30 days
```

Uses the Michael Nygard ADR format: Context, Decision, Consequences, Alternatives Considered, References.

---

### Sprint Health

Assess sprint progress with velocity metrics, hotspots, and risk indicators.

```
/project-pilot:sprint-health                 # Last 14 days
/project-pilot:sprint-health --period 30d    # Last 30 days
/project-pilot:sprint-health --team          # Per-contributor breakdown
```

Detects: velocity trends, late-sprint acceleration (scope pressure), off-hours work patterns (burnout), single-contributor risk areas.

---

### Impact Analysis

Know the blast radius before you change anything.

```
/project-pilot:impact src/auth/session.ts              # File impact
/project-pilot:impact processPayment                    # Function impact
/project-pilot:impact src/auth/ --depth 3               # Deep analysis
```

Maps: direct dependents, transitive dependents, test coverage gaps, config references, git co-change partners (implicit coupling).

---

### Dependency Analysis

Map internal module coupling and external package health.

```
/project-pilot:deps                      # Full analysis
/project-pilot:deps --type internal      # Module graph + circular deps
/project-pilot:deps --type external      # Outdated packages + security
```

Calculates coupling metrics (fan-in, fan-out, instability index) per module.

---

### Breaking Changes

Detect what breaks between two versions.

```
/project-pilot:breaking-changes v1.0.0 v2.0.0     # Between tags
/project-pilot:breaking-changes v1.0.0              # Tag to HEAD
/project-pilot:breaking-changes main feature/new    # Between branches
```

Categories: Definitely Breaking, Likely Breaking, Possibly Breaking, Safe. Includes migration guide.

---

### Bus Factor

Identify knowledge concentration risks.

```
/project-pilot:bus-factor                   # Full history
/project-pilot:bus-factor --period 6m       # Last 6 months
```

Finds: single-owner critical files, inactive contributors owning important code, knowledge distribution heat map.

---

### Onboarding Guide

Generate a complete guide for new team members.

```
/project-pilot:onboard                      # Fullstack guide
/project-pilot:onboard --role frontend      # Frontend focus
/project-pilot:onboard --role backend       # Backend focus
/project-pilot:onboard --role pm            # PM overview
```

Includes: Quick Start, Architecture Overview, Code Tour, Development Workflow, Common Gotchas, Who to Ask.

---

### PM Dashboard

One-page project health overview with a composite health score.

```
/project-pilot:dashboard                    # 14-day overview
/project-pilot:dashboard --period 30d       # 30-day overview
```

Health Score (0-100) based on: velocity consistency, bus factor, tech debt density, dependency health, test presence, CI status.

---

## Multilingual Support

All features support Korean and English output:

- **Auto-detect**: Skills detect the user's language from their message
- **Explicit**: Add `--lang ko` to any slash command for Korean output
- Technical terms (file paths, package names, git refs) always remain in English

---

## Architecture

### Agents (8 specialized sub-agents)

| Agent | Model | Role | Shared By |
|-------|-------|------|-----------|
| `stack-detector` | haiku | Tech stack identification | analyze, onboard, dashboard |
| `structure-analyzer` | haiku | Architecture pattern detection | analyze, onboard, adr |
| `business-logic-tracer` | sonnet | Domain model & workflow tracing | analyze, onboard |
| `git-archaeologist` | sonnet | Decision context from git history | history, adr, sprint-health |
| `debt-scanner` | sonnet | Complexity, TODOs, code smells | debt, dashboard |
| `contributor-analyzer` | haiku | Team patterns & bus factor | sprint-health, bus-factor, dashboard |
| `dependency-mapper` | sonnet | Module graph & package health | deps, impact |
| `change-impact-analyzer` | sonnet | Blast radius & breaking changes | impact, breaking-changes |

**Cost optimization**: haiku for fast data collection, sonnet for analytical reasoning. No opus agents.

### Skills (13 keyword-triggered)

Each feature has a skill with a rich `description` field containing Korean and English trigger keywords. Claude automatically selects the right skill based on your natural language question.

### Hooks (1)

| Event | Purpose |
|-------|---------|
| `SessionStart` | Lightweight project type detection (~2s) for ambient context |

### Risk Scoring Methodology

All risk assessments use a unified formula:

```
Risk Score = Severity(1-4) x Likelihood(1-4) x Age(1.0-2.0) x Centrality(1.0-2.0)
Normalized to 1-10 scale
```

| Score | Level | Badge | Badge (KO) | Action |
|-------|-------|-------|------------|--------|
| 9-10 | Critical | `[CRITICAL]` | `[심각]` | Immediate |
| 7-8 | High | `[HIGH]` | `[높음]` | This sprint |
| 4-6 | Medium | `[MEDIUM]` | `[중간]` | Next quarter |
| 1-3 | Low | `[LOW]` | `[낮음]` | Monitor |

---

## Plugin Structure

```
project-pilot/
├── .claude-plugin/
│   └── plugin.json                     # Plugin metadata
├── skills/                              # 13 keyword-triggered skills
│   ├── analyze/SKILL.md
│   ├── history/SKILL.md
│   ├── debt/SKILL.md
│   ├── release-notes/SKILL.md
│   ├── adr/SKILL.md
│   ├── sprint-health/SKILL.md
│   ├── impact/SKILL.md
│   ├── onboard/SKILL.md
│   ├── deps/SKILL.md
│   ├── breaking-changes/SKILL.md
│   ├── bus-factor/SKILL.md
│   ├── dashboard/SKILL.md
│   └── project-context/                 # Auto-invoked ambient awareness
│       ├── SKILL.md
│       └── references/
│           ├── risk-scoring.md
│           └── output-formats.md
├── commands/                            # 12 slash commands
│   └── [analyze|history|debt|release-notes|adr|sprint-health|impact|onboard|deps|breaking-changes|bus-factor|dashboard].md
├── agents/                              # 8 specialized sub-agents
│   └── [stack-detector|structure-analyzer|business-logic-tracer|git-archaeologist|debt-scanner|contributor-analyzer|dependency-mapper|change-impact-analyzer].md
├── hooks/
│   └── hooks.json                       # SessionStart hook
├── scripts/
│   ├── detect-package-manager.sh        # Project type detection
│   └── check-outdated-deps.sh           # Cross-platform dep checker
├── LICENSE
└── README.md
```

## Requirements

| Requirement | Status | Purpose |
|-------------|--------|---------|
| **Git** | Required | All features depend on git |
| **gh CLI** | Optional | Enhances history/breaking-changes with PR data |
| **Package manager** | Optional | Required for dependency health (npm/pip/cargo/etc.) |

No MCP servers, no API keys, no external services.

## Supported Languages & Frameworks

Project Pilot works with any git repository. Stack detection supports:

**Languages**: JavaScript/TypeScript, Python, Go, Rust, Java/Kotlin, Ruby, PHP, C#/.NET, Dart/Flutter, Swift, Elixir

**Frameworks**: React, Next.js, Vue, Nuxt, Angular, Svelte, Express, Fastify, NestJS, Django, FastAPI, Flask, Gin, Echo, Fiber, Actix, Axum, Spring Boot, Rails, Laravel

**Package Managers**: npm, yarn, pnpm, bun, pip, poetry, pipenv, uv, cargo, go modules, Maven, Gradle, bundler, composer

---

## License

MIT License - see [LICENSE](LICENSE) file.

## Contributing

Issues and pull requests welcome at [bukoo93/project-pilot](https://github.com/bukoo93/project-pilot).

## Author

Built with Claude Code.
