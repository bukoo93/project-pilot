---
name: release-notes
description: "Generate release notes from git history. Use when the user asks: 릴리즈 노트, release notes, 변경 사항 정리, changelog, 배포 노트, deploy notes, 이번 릴리즈 뭐 바뀌었어, what changed since last release, 태그 이후 변경점, changes since tag, 릴리즈 요약, release summary, 변경 로그 만들어줘"
tools: Bash, Read, Glob, Grep
---

# Release Notes Generator (Keyword-Triggered)

The user wants release notes or a changelog.

## Detect Parameters from Context

- If the user mentions a specific tag/ref → use it as starting point
- If not → find last tag: `git describe --tags --abbrev=0 2>/dev/null`
- If no tags → use root commit or ask user
- Detect preferred format from context (stakeholder = narrative, developer = changelog)

## Detect Language Preference

- Korean message → Korean output
- English message → English output

## Workflow (No agent needed — direct git analysis)

1. **Gather commits**: `git log <since>..HEAD --pretty=format:"%H|%s|%an|%ad" --date=short`
2. **Categorize** each commit:
   - Conventional commits: parse `feat:`, `fix:`, `docs:`, `refactor:`, etc.
   - Non-conventional: infer from keywords (add/new → Feature, fix/resolve → Bug Fix, etc.)
3. **Generate** grouped release notes

## Output Format

```markdown
## Release Notes — [date]

### ✨ New Features
- description (commit-hash)

### 🐛 Bug Fixes
- description (commit-hash)

### 🔧 Other Changes
- description (commit-hash)

---
Stats: N commits, N files changed | Contributors: names
```