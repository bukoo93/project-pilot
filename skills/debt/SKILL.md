---
name: tech-debt
description: "Scan for technical debt: complex code, stale TODOs, outdated dependencies. Use when the user asks: 기술 부채, technical debt, 코드 품질, code quality, TODO 정리, stale todos, 복잡한 코드 찾아줘, find complex code, 리팩토링 필요한 곳, what needs refactoring, 오래된 라이브러리, outdated dependencies, 코드 스멜, code smell, 코드 건강, code health check, 부채 리포트, debt report"
tools: Bash, Read, Glob, Grep
---

# Technical Debt Scan (Keyword-Triggered)

The user is asking about code quality, technical debt, or areas that need improvement.

## Detect Language Preference

- Korean message → Korean output
- English message → English output

## Workflow

Launch a **sonnet agent** (debt-scanner) to scan for:

### 1. Complexity Hotspots
- Files > 500 lines
- Deeply nested code (4+ levels)
- Functions with many parameters (5+)

### 2. Stale TODOs
- Grep for TODO/FIXME/HACK/XXX/WORKAROUND
- Cross-reference with `git blame` for age
- Flag anything older than 3 months

### 3. Outdated Dependencies
- Run `${CLAUDE_PLUGIN_ROOT}/scripts/check-outdated-deps.sh` if available
- Or detect package manager and run outdated check directly

### 4. Code Smells
- Commented-out code blocks
- God files (>1000 lines)
- Inconsistent patterns

## Risk Scoring

For each finding, calculate risk score (1-10):
- Severity(1-4) x Likelihood(1-4) x Age(1.0-2.0) x Centrality(1.0-2.0), normalized

Categories: [CRITICAL] 9-10 | [HIGH] 7-8 | [MEDIUM] 4-6 | [LOW] 1-3

## Output Format

```markdown
## 🔍 Technical Debt Report

### Summary
> N findings: N critical, N high, N medium, N low

### Top Riskiest Items
[Table with score, category, location, description, age]

### Recommended Actions
1. [This sprint: critical items]
2. [Next sprint: high items]
3. [Backlog: medium/low items]
```