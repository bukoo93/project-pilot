---
description: "Analyze blast radius of changes to a file, function, or module"
argument-hint: "<file-or-function> [--depth 1|2|3] [--lang ko]"
allowed-tools: ["Bash", "Read", "Glob", "Grep"]
---

# Impact Analysis

Launch 2 agents in parallel:
- **change-impact-analyzer (sonnet)**: Direct/transitive dependents, test coverage, config refs, co-change analysis
- **dependency-mapper (sonnet)**: Target position in graph, fan-in/fan-out, circular deps

Output: Blast radius summary, dependency rings, test gaps, implicit coupling, safe change checklist.
