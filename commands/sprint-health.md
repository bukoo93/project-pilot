---
description: "Analyze sprint health: velocity, commit patterns, hotspots, risks"
argument-hint: "[--period 7d|14d|30d] [--team] [--lang ko]"
allowed-tools: ["Bash", "Read", "Glob", "Grep"]
---

# Sprint Health Dashboard

Gather git metrics for period (default 14d):
- Commits/day, lines changed, files touched
- Top 10 hotspot files, contributor activity
- Commit time distribution (crunch patterns)

If --team: launch contributor-analyzer (haiku).
Risk flags: high-churn complex files, single-contributor areas, late acceleration, off-hours spikes.
