---
description: "Explain why code was written a certain way using git history, blame, and related commits"
argument-hint: "<file-or-function> [--depth deep|shallow] [--lang ko]"
allowed-tools: ["Bash", "Read", "Glob", "Grep"]
---

# History Explanation

1. Resolve target (file path or function name via Grep)
2. Launch **git-archaeologist (sonnet)** agent
3. Shallow: last 5 changes + blame. Deep: full history + PRs + co-changed files + reverts
4. Output: Quick Context, Decision Timeline, Narrative, Key Takeaways, Metrics
