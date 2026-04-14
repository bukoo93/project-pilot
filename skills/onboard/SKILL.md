---
name: onboarding-guide
description: "Generate onboarding guide for new team members. Use when the user asks: 온보딩 가이드, onboarding guide, 신규 입사자 가이드, new member guide, 프로젝트 시작하려면, how to get started, 셀업 방법, setup guide, 개발 환경 세팅, dev environment setup, 이 프로젝트 처음인데, I'm new to this project, 코드 투어, code tour, 프로젝트 입문"
tools: Bash, Read, Glob, Grep
---

# Onboarding Guide Generator (Keyword-Triggered)

The user is new to the project or wants to create a guide for newcomers.

## Detect Role

From context:
- Mentions frontend/UI → frontend focus
- Mentions backend/API/server → backend focus
- Mentions PM/manager → PM overview (skip setup details)
- Default → fullstack

## Detect Language Preference

- Korean message → Korean output
- English message → English output

## Workflow

Launch **3 agents in parallel**:

1. **Stack Detector (haiku)**: Technologies to know
2. **Structure Analyzer (haiku)**: Project navigation map
3. **Business Logic Tracer (sonnet)**: Domain concepts and workflows

Also gather: README.md, CONTRIBUTING.md, package.json scripts, .env.example, docker-compose.yml, git branch patterns, recent activity areas.

## Output

Comprehensive guide with:
1. Quick Start (5-minute setup)
2. Architecture Overview
3. Key Concepts & Domain Model
4. Code Tour (most important files to read first)
5. Development Workflow
6. Common Gotchas
7. Who to Ask (from git contributors)