---
name: project-analyze
description: "Analyze project tech stack, folder structure, architecture, and business logic. Use when the user asks: 프로젝트 분석, 기술 스택, tech stack, what technologies, what framework, project structure, 폴더 구조, 아키텍처, architecture, what does this project use, 이 프로젝트 뭐로 만들었어, 프로젝트 구조 알려줘, explain this codebase, 코드베이스 설명, project overview, 프로젝트 개요"
tools: Bash, Read, Glob, Grep
---

# Project Analysis (Keyword-Triggered)

The user is asking about the project's technology, structure, or domain. Perform a comprehensive analysis.

## Detect Language Preference

- If the user's message is in Korean → output in Korean (technical terms stay in English)
- If in English → output in English

## Workflow

Launch up to 3 agents in parallel based on what the user is asking:

### If asking about tech stack / technologies / 기술 스택:
Launch a **haiku agent** to detect:
- Language, framework, package manager from manifest files (package.json, pyproject.toml, Cargo.toml, go.mod, etc.)
- Build tools, test framework, linters, CI/CD, database, infrastructure
- Monorepo detection

### If asking about structure / architecture / 구조 / 아키텍처:
Launch a **haiku agent** to:
- Map directory tree (2 levels deep, exclude node_modules/vendor/.git/dist)
- Identify architectural pattern (MVC, layered, hexagonal, feature-based, etc.)
- Find entry points, rate separation of concerns

### If asking about business logic / what the project does / 뭐하는 프로젝트:
Launch a **sonnet agent** to:
- Find domain models/entities
- Map API endpoints
- Identify core workflows and business rules
- Trace data flow

### If the question is general (overview / 분석 / explain):
Launch all 3 agents in parallel.

## Output Format

```markdown
## 📊 Project Analysis

### Tech Stack
[Language, framework, key libraries, build/test/CI tools]

### Architecture
[Pattern, directory map, entry points]

### Business Domain
[What the project does, core entities, key workflows]

### Key Observations
[Cross-cutting insights, strengths, concerns]
```