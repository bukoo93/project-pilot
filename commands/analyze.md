---
description: "Analyze project tech stack, folder structure, architecture patterns, and business logic"
argument-hint: "[focus: stack|structure|logic|all] [--lang ko]"
allowed-tools: ["Bash", "Read", "Glob", "Grep"]
---

# Project Analysis

Perform a comprehensive project analysis. Parse `$ARGUMENTS` for:
- **focus**: `stack`, `structure`, `logic`, or `all` (default: `all`)
- **--lang ko**: Output in Korean (technical terms stay in English)

## Workflow

### Step 1: Determine Focus
Parse `$ARGUMENTS`:
- If empty or "all" → run all 3 analyses
- If "stack" → only tech stack
- If "structure" → only architecture
- If "logic" → only business logic

### Step 2: Launch Parallel Agents

Based on focus, launch up to 3 agents **in parallel** (use Haiku for stack-detector and structure-analyzer, Sonnet for business-logic-tracer):

#### Agent 1: Stack Detection (haiku)
Prompt the agent to:
- Read manifest files (package.json, pyproject.toml, Cargo.toml, go.mod, pom.xml, etc.)
- Detect language, framework, package manager, build tools, test framework, linters, CI/CD, database, infrastructure
- Check for monorepo indicators (workspaces, turbo.json, nx.json, lerna.json)
- Return a structured tech stack profile

#### Agent 2: Structure Analysis (haiku)
Prompt the agent to:
- List directory tree (max 2 levels deep, excluding node_modules/vendor/target/dist/.git)
- Identify architectural pattern (MVC, layered, hexagonal, feature-based, etc.) with confidence level
- Map each directory's purpose and architecture role
- Find entry points
- Rate separation of concerns (A/B/C/D)

#### Agent 3: Business Logic Tracing (sonnet)
Prompt the agent to:
- Find domain models/entities with fields and relationships
- Map API endpoints and their purposes
- Identify core workflows and business rules
- Trace data flow from request to response
- Find external service integrations
- Note key algorithms or complex logic

### Step 3: Aggregate Results

Combine all agent outputs into a single report.

### Step 4: Generate Report

Format the output following the template below.

## Output Template

```markdown
## 📊 Project Analysis Report
Generated: [date] | Focus: [all/stack/structure/logic]

---

### 1. Tech Stack
[Stack detector output]

### 2. Architecture
[Structure analyzer output]

### 3. Business Domain
[Business logic tracer output]

---

### 4. Key Observations
- [Cross-cutting observations from combining all three analyses]
- [Strengths of the current setup]
- [Potential concerns or improvement areas]

### 5. Quick Reference
| Aspect | Value |
|--------|-------|
| Language | [lang] |
| Framework | [framework] |
| Architecture | [pattern] |
| Domain | [1-line domain summary] |
| Size | [~N files] |
| Maturity | [early/growing/mature based on git age and structure] |
```

## Korean Output (--lang ko)

If `--lang ko` is in arguments, translate all section headers and prose to Korean:
- "Project Analysis Report" → "프로젝트 분석 리포트"
- "Tech Stack" → "기술 스택"
- "Architecture" → "아키텍처"
- "Business Domain" → "비즈니스 도메인"
- "Key Observations" → "주요 관찰사항"
- "Quick Reference" → "빠른 참조"

Keep all technical identifiers (file paths, package names, framework names) in English.