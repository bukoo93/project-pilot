---
name: impact-analysis
description: "Analyze blast radius of code changes. Use when the user asks: 영향도 분석, impact analysis, 이거 바꾸면 뭐가 깨져, what breaks if I change this, blast radius, 변경 영향, change impact, 이 파일 수정하면 어디에 영향, what depends on this, 의존성 추적, dependency trace, 이거 건드려도 되나, is it safe to change this"
tools: Bash, Read, Glob, Grep
---

# Impact Analysis (Keyword-Triggered)

The user wants to know the blast radius of changing a specific file, function, or module.

## Detect Target

From the user's message, identify:
- A file path
- A function/class name
- A module/directory

If unclear, ask the user to specify.

## Detect Language Preference

- Korean message → Korean output
- English message → English output

## Workflow

Launch **two sonnet agents in parallel**:

### Agent A: Change Impact Analyzer
- Find direct dependents (files importing the target)
- Trace transitive dependents (depth 2)
- Find test coverage
- Check config/build references
- Git co-change analysis

### Agent B: Dependency Mapper
- Target's position in the dependency graph
- Fan-in/fan-out metrics
- Circular dependencies involving target

## Output

Impact summary with dependency rings, test coverage gaps, co-change partners, risk level, and safe change checklist.