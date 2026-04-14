---
description: "Scan codebase for technical debt with risk scores"
argument-hint: "[scope: full|src|path] [--threshold low|medium|high] [--lang ko]"
allowed-tools: ["Bash", "Read", "Glob", "Grep"]
---

# Technical Debt Report

Launch **debt-scanner (sonnet)** to scan 5 categories:
1. Complexity hotspots (>500 LOC, deep nesting, many params)
2. Stale TODOs (cross-ref with git blame for age)
3. Outdated dependencies (check-outdated-deps.sh)
4. Dead code indicators
5. Code smells

Risk score 1-10: Severity x Likelihood x Age x Centrality.
Filter by --threshold: low(all), medium(4+, default), high(7+).
