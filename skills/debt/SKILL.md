---
name: tech-debt
description: "Scan for technical debt. Use when: 기술 부채, technical debt, 코드 품질, code quality, TODO 정리, stale todos, 복잡한 코드, find complex code, 리팩토링 필요한 곳, what needs refactoring, 오래된 라이브러리, outdated dependencies, code smell, 코드 건강, debt report"
tools: Bash, Read, Glob, Grep
---

# Technical Debt (Keyword-Triggered)

Launch sonnet agent (debt-scanner) for complexity, TODOs, outdated deps, dead code, code smells.
Risk score 1-10 per finding. Output: Summary, Top Items, Recommended Actions.
