---
name: impact-analysis
description: "Analyze blast radius of changes. Use when: 영향도 분석, impact analysis, 이거 바꾸면 다가 깨져, what breaks if I change this, blast radius, 변경 영향, 이 파일 수정하면, what depends on this, 이거 건드려도 되나, is it safe to change this"
tools: Bash, Read, Glob, Grep
---

# Impact Analysis (Keyword-Triggered)

Launch 2 sonnet agents: change-impact-analyzer + dependency-mapper.
Output: Dependency rings, test coverage gaps, co-change partners, risk level, safe change checklist.
