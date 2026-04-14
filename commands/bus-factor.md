---
description: "Identify knowledge concentration risks and bus factor"
argument-hint: "[--period 6m|1y|all] [--lang ko]"
allowed-tools: ["Bash", "Read", "Glob", "Grep"]
---

# Bus Factor Analysis

For each source file, count unique contributors via git log.
Launch contributor-analyzer (haiku) for:
- Files with bus factor 1 (sole contributor or >80% ownership)
- Cross-reference with file importance (import count)
- Check if primary owners still active (last 90 days)
- Project-level bus factor calculation

Output: Bus factor score, critical single-owner files, knowledge heat map, recommendations.
