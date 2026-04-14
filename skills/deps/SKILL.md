---
name: dependency-analysis
description: "Analyze project dependencies. Use when the user asks: 의존성 분석, dependency analysis, 순환 의존성, circular dependency, 패키지 건강도, package health, 오래된 패키지, outdated packages, 보안 취약점, security vulnerabilities, npm audit, 의존성 그래프, dependency graph, 결합도, coupling, 모듈 의존성, module dependencies"
tools: Bash, Read, Glob, Grep
---

# Dependency Analysis (Keyword-Triggered)

The user is asking about internal module dependencies or external package health.

## Detect Focus

From the user's message:
- "internal" / "모듈" / "circular" / "순환" → internal module analysis
- "external" / "패키지" / "outdated" / "보안" / "audit" → external package health
- General → both

## Detect Language Preference

- Korean message → Korean output
- English message → English output

## Workflow

Launch **sonnet agent** (dependency-mapper) to:

### Internal
- Build import graph from source files
- Calculate coupling metrics (fan-in, fan-out, instability)
- Detect circular dependencies
- Check boundary violations

### External
- Read manifest files for dependencies
- Run outdated check (`npm outdated`, `pip list --outdated`, etc.)
- Run security audit if available
- Count per-package usage (coupling degree)

## Output

Module coupling table, circular dependency list, dependency graph, outdated packages, security advisories, and recommendations.