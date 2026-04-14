---
name: bus-factor
description: "Analyze knowledge concentration and bus factor risks. Use when the user asks: 버스 팩터, bus factor, 지식 집중도, knowledge concentration, 한 사람만 아는 코드, single point of failure, 코드 소유권, code ownership, 누가 이 코드 담당, who owns this code, 리스크 분석, risk analysis, 팀 의존성, team dependency, 핵심 인력 리스크, key person risk"
tools: Bash, Read, Glob, Grep
---

# Bus Factor Analysis (Keyword-Triggered)

The user is asking about knowledge concentration, code ownership, or team dependency risks.

## Detect Language Preference

- Korean message → Korean output
- English message → English output

## Workflow

1. List all source files (exclude generated/vendor)
2. Launch **haiku agent** (contributor-analyzer) to:
   - Count unique contributors per file
   - Identify files where one person owns >80% of commits
   - Cross-reference with file importance (how many files depend on it)
   - Check if primary owners are still active (committed in last 90 days)
   - Calculate project-level bus factor

## Output

Bus factor score, critical single-owner files, knowledge distribution heat map, and recommendations for knowledge sharing.