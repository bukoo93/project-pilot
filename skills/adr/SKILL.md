---
name: adr-generator
description: "Generate Architecture Decision Records. Use when the user asks: ADR 만들어, ADR 작성, architecture decision record, 아키텍처 결정 기록, 기술 결정 문서화, document this decision, 왜 이 기술 선택했는지 기록, record this architectural choice, 의사결정 기록, decision record"
tools: Bash, Read, Glob, Grep
---

# ADR Generator (Keyword-Triggered)

The user wants to create an Architecture Decision Record.

## Detect Topic

From the user's message:
- If they mention a specific topic → use it as the ADR title
- If they say "auto" or just "ADR 만들어" → analyze recent changes to infer the decision

## Detect Language Preference

- Korean message → Korean output
- English message → English output

## Workflow

### Auto-detect mode
1. Run `git log --since="7 days ago" --pretty=format:"%H|%s" --name-only`
2. Launch **sonnet agent** to identify the most significant architectural change
3. If no significant change found, ask the user to specify a topic

### Manual topic mode
1. Search codebase for relevant code
2. Search git history for when/why the pattern was introduced

### Generate ADR

Use Michael Nygard format:
- **Title**: ADR-YYYY-MM-DD-topic
- **Status**: Proposed
- **Context**: Why this decision was needed
- **Decision**: What was chosen
- **Consequences**: Positive, negative, neutral
- **Alternatives Considered**: What else was evaluated
- **References**: Commits, PRs, issues

After generating, offer to write to `docs/adr/`.