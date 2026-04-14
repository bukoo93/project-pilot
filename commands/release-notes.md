---
description: "Auto-generate release notes from git history since last tag"
argument-hint: "[since-ref] [--format changelog|narrative|bullet] [--include-breaking] [--lang ko]"
allowed-tools: ["Bash", "Read", "Glob", "Grep"]
disable-model-invocation: true
---

# Release Notes Generator

No agents needed. Direct git analysis:
1. Find starting point: last tag or specified ref
2. Gather commits: `git log <ref>..HEAD`
3. Categorize: conventional commits (feat/fix/docs/refactor) or keyword inference
4. Format: changelog (default), narrative (stakeholders), bullet (simple)
