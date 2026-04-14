---
description: "Generate Architecture Decision Record from recent changes or topic"
argument-hint: "<topic-or-auto> [--since 7d|30d] [--lang ko]"
allowed-tools: ["Bash", "Read", "Glob", "Grep"]
disable-model-invocation: true
---

# ADR Generator

Auto mode: analyze recent git changes for significant architectural decisions.
Manual: search codebase and git history for specified topic.

Michael Nygard format: Context, Decision, Consequences (positive/negative/neutral), Alternatives Considered, References.
File: ADR-YYYY-MM-DD-topic.md in docs/adr/
