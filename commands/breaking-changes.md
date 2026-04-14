---
description: "Detect breaking changes between two refs"
argument-hint: "<from-ref> <to-ref> [--lang ko]"
allowed-tools: ["Bash", "Read", "Glob", "Grep"]
---

# Breaking Change Detection

Compare two git refs. Launch change-impact-analyzer (sonnet) to detect:
- Removed/renamed exports, changed signatures
- Schema changes (DB migrations, interfaces)
- New required config/env vars
- Major dependency version bumps

Categorize: Definitely Breaking, Likely Breaking, Possibly Breaking, Safe.
Includes migration guide.
