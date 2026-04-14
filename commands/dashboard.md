---
description: "PM dashboard combining project health, velocity, debt, and risk metrics"
argument-hint: "[--period 14d|30d] [--lang ko]"
allowed-tools: ["Bash", "Read", "Glob", "Grep"]
---

# PM Dashboard

Orchestrator command. Direct git metrics + 3 haiku agents in parallel:
- Quick debt scan (TODOs, long files, outdated deps)
- Quick bus factor (top 10 hotspots)
- Quick risk scan (git status, CI, security audit)

Health Score 0-100: velocity(20%) + bus factor(20%) + debt(20%) + deps(15%) + tests(15%) + CI(10%).
