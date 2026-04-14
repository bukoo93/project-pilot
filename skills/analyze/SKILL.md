---
name: project-analyze
description: "Analyze project tech stack, folder structure, architecture, and business logic. Use when the user asks: 프로젝트 분석, 기술 스택, tech stack, what technologies, what framework, project structure, 폴더 구조, 아키텍처, architecture, what does this project use, 이 프로젝트 다로 만들었어, 프로젝트 구조 알려줘, explain this codebase, project overview, 프로젝트 개요"
tools: Bash, Read, Glob, Grep
---

# Project Analysis (Keyword-Triggered)

Launch up to 3 agents based on user's question:
- Tech stack: haiku agent for manifest/config scanning
- Structure: haiku agent for directory mapping and pattern detection
- Business logic: sonnet agent for domain model and workflow tracing
- General question: all 3 in parallel

Auto-detect language from user's message for output.
