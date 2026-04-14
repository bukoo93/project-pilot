---
name: release-notes
description: "Generate release notes. Use when: 릴리즈 노트, release notes, 변경 사항 정리, changelog, 배포 노트, what changed since last release, 태그 이후 변경점, release summary, 변경 로그 만들어줘"
tools: Bash, Read, Glob, Grep
---

# Release Notes (Keyword-Triggered)

Direct git analysis (no agents). Find last tag, gather commits, categorize (conventional or keyword inference), generate grouped notes.
