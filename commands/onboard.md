---
description: "Generate onboarding guide for new team members"
argument-hint: "[--role frontend|backend|fullstack|pm] [--lang ko]"
allowed-tools: ["Bash", "Read", "Glob", "Grep"]
disable-model-invocation: true
---

# Onboarding Guide Generator

Launch 3 agents: stack-detector (haiku), structure-analyzer (haiku), business-logic-tracer (sonnet).
Also gather: README, CONTRIBUTING, package.json scripts, .env.example, docker-compose, git branches.

Output by role: Quick Start, Architecture Overview, Key Concepts, Code Tour, Dev Workflow, Common Gotchas, Who to Ask.
