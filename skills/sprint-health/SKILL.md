---
name: sprint-health
description: "Analyze sprint health and development velocity. Use when the user asks: 스프린트 건강도, sprint health, 개발 속도, velocity, 커밋 패턴, commit patterns, 팀 생산성, team productivity, 이번 스프린트 어때, how is the sprint going, 개발 현황, development status, 핫스팟, hotspots, 작업 현황 분석, work status analysis"
tools: Bash, Read, Glob, Grep
---

# Sprint Health Dashboard (Keyword-Triggered)

The user is asking about development velocity, sprint progress, or team activity.

## Detect Parameters

- If user mentions a time period → use it (e.g., "이번 주" = 7d, "이번 달" = 30d)
- Default: 14 days
- If user mentions team/contributors → include per-person breakdown

## Detect Language Preference

- Korean message → Korean output
- English message → English output

## Workflow

1. **Gather git metrics** for the period:
   - Commits per day, total lines changed, files touched
   - Top 10 most-changed files (hotspots)
   - Contributor activity
   - Commit time distribution (detect crunch patterns)

2. **If team details requested**, launch **haiku agent** (contributor-analyzer):
   - Per-author commit counts and areas
   - Knowledge concentration
   - Activity status (active/recent/inactive)

3. **Risk assessment**:
   - High-churn complex files
   - Single-contributor areas
   - Late-sprint acceleration (scope pressure indicator)
   - Off-hours work pattern (burnout indicator)

## Output

Sprint dashboard with velocity metrics, hotspots, risk flags, and action items.