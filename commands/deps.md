---
description: "Analyze internal and external dependencies"
argument-hint: "[--type internal|external|all] [--lang ko]"
allowed-tools: ["Bash", "Read", "Glob", "Grep"]
---

# Dependency Analysis

Launch dependency-mapper (sonnet):
- Internal: import graph, coupling metrics (fan-in/fan-out/instability), circular deps, boundary violations
- External: outdated check, security audit, per-package usage count, heavily coupled packages
