---
description: "Analyze project tech stack, folder structure, architecture patterns, and business logic"
argument-hint: "[focus: stack|structure|logic|all] [--lang ko]"
allowed-tools: ["Bash", "Read", "Glob", "Grep"]
---

# Project Analysis

Launch up to 3 parallel agents based on focus (default: all):
- **Stack Detection (haiku)**: Manifest files, framework, build/test/CI tools, monorepo
- **Structure Analysis (haiku)**: Directory tree, architectural pattern, entry points, separation of concerns
- **Business Logic (sonnet)**: Domain models, API endpoints, workflows, data flow

If `--lang ko`, output in Korean (technical terms in English).
