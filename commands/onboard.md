---
description: "Generate a comprehensive onboarding guide for new team members joining this project"
argument-hint: "[--role frontend|backend|fullstack|pm] [--lang ko]"
allowed-tools: ["Bash", "Read", "Glob", "Grep", "Agent"]
---

# Onboarding Guide Generator

Generate a comprehensive guide for new team members joining this project.

## Argument Parsing

Parse `$ARGUMENTS` for:
- **--role**: `frontend`, `backend`, `fullstack` (default), or `pm`
- **--lang ko**: Output in Korean

## Workflow

### Step 1: Launch 3 Parallel Agents

#### Agent 1: Stack Detector (haiku)
Identify all technologies a new team member needs to know.

#### Agent 2: Structure Analyzer (haiku)
Map the project for newcomer navigation — entry points, key directories, architecture pattern.

#### Agent 3: Business Logic Tracer (sonnet)
Identify core domain concepts, key workflows, and API surface.

### Step 2: Gather Additional Context

While agents run, also gather:

```bash
# README content
cat README.md 2>/dev/null | head -100

# Contributing guide
cat CONTRIBUTING.md 2>/dev/null | head -100

# Available scripts/commands
cat package.json 2>/dev/null | grep -A 30 '"scripts"'
cat Makefile 2>/dev/null | grep "^[a-zA-Z].*:" | head -20

# Environment template
cat .env.example 2>/dev/null | head -30
cat .env.template 2>/dev/null | head -30

# Docker setup
cat docker-compose.yml 2>/dev/null | head -50

# Git branch strategy (infer from branch names)
git branch -a | head -20

# Recent active areas (where would a new person likely work?)
git log --since="30 days ago" --name-only --pretty=format:"" | sort | uniq -c | sort -rn | head -15

# Common gotchas (reverts and fix commits)
git log --all --oneline --grep="revert\|hotfix\|workaround\|hack" | head -10
```

### Step 3: Compile by Role

Filter and emphasize content based on role:
- **frontend**: Focus on UI components, state management, build tools, design system
- **backend**: Focus on API, database, services, deployment
- **fullstack**: Everything
- **pm**: High-level architecture, domain model, key workflows, team structure (skip setup details)

### Step 4: Generate Guide

## Output Template

```markdown
## 👋 Onboarding Guide: [Project Name]
Role: [role] | Generated: [date]

---

### 1. Quick Start (5 minutes)

#### Prerequisites
- [Tool 1] — [version, install link]
- [Tool 2] — [version, install link]

#### Setup Steps
```bash
# Clone
git clone <repo-url>
cd <project-name>

# Install dependencies
[detected package manager install command]

# Environment setup
cp .env.example .env
# Edit .env with required values: [list required vars]

# Database setup (if applicable)
[detected db setup command]

# Start development server
[detected start command]

# Verify: open http://localhost:[port]
```

#### Run Tests
```bash
[detected test command]
```

### 2. Architecture Overview

#### Tech Stack
[From stack-detector: language, framework, key libraries]

#### Architecture Pattern
[From structure-analyzer: pattern name, diagram]

#### Directory Guide
| Directory | What's Inside | Start Here? |
|-----------|--------------|-------------|
| `src/components/` | UI components | ⭐ Frontend |
| `src/api/` | API endpoints | ⭐ Backend |
| `src/services/` | Business logic | ⭐ All |
| `src/models/` | Data models | Reference |
| `tests/` | Test files | Reference |

### 3. Key Concepts

#### Domain Model
[From business-logic-tracer: core entities and their relationships]

#### Core Workflows
1. **[Workflow 1]**: [Brief step-by-step]
2. **[Workflow 2]**: [Brief step-by-step]

#### API Overview (if backend/fullstack)
| Endpoint Group | Base Path | Purpose |
|----------------|-----------|--------|
| Auth | /api/auth/ | Login, register, session |
| Users | /api/users/ | User management |

### 4. Code Tour — Read These First

The most important files to understand, in suggested reading order:

| # | File | Why Read This | Estimated Time |
|---|------|--------------|----------------|
| 1 | `src/app.ts` | Main entry point | 5 min |
| 2 | `src/models/index.ts` | All domain models | 10 min |
| 3 | `src/services/auth.ts` | Core auth logic | 10 min |
| 4 | ... | ... | ... |

### 5. Development Workflow

#### Branch Strategy
[Inferred from git branch patterns: gitflow, trunk-based, feature-branch]

#### Making Changes
1. Create branch: `git checkout -b feature/your-feature`
2. Make changes
3. Run tests: `[test command]`
4. Run lint: `[lint command]`
5. Commit with conventional format: `feat: description`
6. Push and create PR

#### CI/CD
[From CI config: what runs on PR, what runs on merge]

### 6. Common Gotchas

[From git history analysis of reverts and workarounds]

- ⚠️ [Gotcha 1]: [explanation and how to avoid]
- ⚠️ [Gotcha 2]: [explanation and how to avoid]

### 7. Resources

- README: [if exists, what's useful in it]
- API Docs: [if OpenAPI/Swagger exists]
- Design System: [if Storybook exists]
- CI Dashboard: [if detectable]

### 8. Who to Ask

[From git log: most active contributors and their primary areas]

| Area | Go-to Person | Contact |
|------|-------------|--------|
| Auth | [most active author in auth/] | - |
| UI | [most active author in ui/] | - |
```

## Korean Output (--lang ko)

All section headers and prose in Korean:
- "Onboarding Guide" → "온보딩 가이드"
- "Quick Start" → "빠른 시작"
- "Architecture Overview" → "아키텍처 개요"
- "Key Concepts" → "핵심 개념"
- "Code Tour" → "코드 투어"
- "Development Workflow" → "개발 워크플로우"
- "Common Gotchas" → "자주 겪는 문제"
- "Who to Ask" → "누구에게 물어볼까"