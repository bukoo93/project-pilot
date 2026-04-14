---
name: breaking-change-detection
description: "Detect breaking changes between versions. Use when the user asks: 브레이킹 체인지, breaking changes, 호환성 깨지는 거, what breaks between versions, 업그레이드 영향, upgrade impact, 마이그레이션 필요한 거, migration needed, API 변경, API changes, 이전 버전이랑 뭐가 달라, what changed between versions, 하위 호환성, backward compatibility"
tools: Bash, Read, Glob, Grep
---

# Breaking Change Detection (Keyword-Triggered)

The user wants to know what breaking changes exist between two versions/refs.

## Detect Refs

From the user's message:
- If two refs mentioned → use them (e.g., "v1.0 vs v2.0")
- If one ref mentioned → compare it to HEAD
- If none → compare last tag to HEAD

If unclear, ask the user which versions to compare.

## Detect Language Preference

- Korean message → Korean output
- English message → English output

## Workflow

1. Get changed files: `git diff <from>..<to> --name-only`
2. Launch **sonnet agent** (change-impact-analyzer) to detect:
   - Removed/renamed exports
   - Changed function signatures
   - Schema changes (DB migrations, interface changes)
   - New required config/env vars
   - Dependency breaking changes (major version bumps)
3. Categorize: 🔴 Definitely Breaking → 🟠 Likely → 🟡 Possibly → 🟢 Safe

## Output

Breaking change summary with categorized findings and migration guide.