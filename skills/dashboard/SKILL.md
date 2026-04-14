---
name: project-dashboard
description: "Show project health dashboard with combined metrics. Use when the user asks: 프로젝트 대시보드, project dashboard, 프로젝트 건강도, project health, 전체 현황, overall status, 프로젝트 상태, project status, 건강 점수, health score, 프로젝트 리포트, project report, 종합 분석, comprehensive analysis, PM 리포트, PM report, 프로젝트 요약, project summary"
tools: Bash, Read, Glob, Grep
---

# PM Dashboard (Keyword-Triggered)

The user wants a comprehensive project health overview.

## Detect Language Preference

- Korean message → Korean output
- English message → English output

## Workflow

### Step 1: Direct Metrics (no agents)
- Commit count and velocity for last 14 days
- Active contributors
- Top 10 hotspot files
- Unmerged branch count
- Last tag distance

### Step 2: Launch 3 haiku agents in parallel

**Agent A — Quick Debt Scan**: Count TODOs, find files >500 LOC, check outdated deps count
**Agent B — Quick Bus Factor**: For top 10 hotspots, check unique contributors
**Agent C — Quick Risk Scan**: Check git status, CI status (if gh available), security audit summary

### Step 3: Compute Health Score (0-100)

| Component | Weight |
|-----------|--------|
| Velocity consistency | 20% |
| Bus factor | 20% |
| Tech debt density | 20% |
| Dependency health | 15% |
| Test presence | 15% |
| CI status | 10% |

## Output

Single-page dashboard with health score, velocity, hotspots, top risks, dependency status, bus factor, and 3 priority action items.