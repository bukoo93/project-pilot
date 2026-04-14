---
description: "Generate an Architecture Decision Record from recent code changes or a specified topic"
argument-hint: "<topic-or-auto> [--since 7d|30d|commit-ref] [--lang ko]"
allowed-tools: ["Bash", "Read", "Glob", "Grep", "Agent"]
---

# ADR (Architecture Decision Record) Generator

Generate a standardized Architecture Decision Record based on recent code changes or a specified topic.

## Argument Parsing

Parse `$ARGUMENTS` for:
- **topic** (positional): A topic string (e.g., "switch from REST to GraphQL") or `auto` to auto-detect from recent changes
- **--since**: Time range for `auto` mode. Default: `7d`. Accepts: `7d`, `14d`, `30d`, or a commit ref
- **--lang ko**: Output in Korean

## Workflow

### Step 1: Determine the Decision

#### Auto Mode (topic is `auto` or empty)
1. Get recent changes:
```bash
git log --since="7 days ago" --pretty=format:"%H|%s|%an|%ad" --date=short --name-only
```

2. Launch a **Sonnet agent** (as git-archaeologist) to analyze the changes and identify the most significant architectural decision. Look for:
   - New libraries or frameworks added (check manifest file diffs)
   - New architectural patterns introduced (new directory structures, new base classes)
   - Major refactoring (file moves, renames, structural reorganization)
   - Infrastructure changes (new Docker configs, CI changes, deployment changes)
   - Database schema changes (new migrations, model changes)

3. If no significant architectural change found, report this and suggest the user specify a topic manually.

#### Manual Mode (topic is a string)
1. Use the provided topic as the ADR title
2. Search the codebase for relevant code using Grep and Glob
3. Search git history for when/why the pattern was introduced:
```bash
git log --all --grep="<topic keywords>" --pretty=format:"%H|%s|%an|%ad" --date=short
git log --all -S "<topic keywords>" --pretty=format:"%H|%s|%an|%ad" --date=short
```

### Step 2: Gather Context

For the identified decision:
1. **What files were affected**: List the primary files involved
2. **What was the previous state**: Check `git diff` or `git show` for the "before"
3. **What alternatives existed**: Check if other approaches were tried and reverted. Look for commented-out code, TODO comments mentioning alternatives
4. **Who made the decision**: Primary author(s) from git log
5. **What trade-offs were made**: Analyze what became easier/harder

### Step 3: Check ADR Directory

```bash
# Check if ADR directory exists
ls -d docs/adr/ docs/decisions/ docs/architecture-decisions/ 2>/dev/null

# Count existing ADRs for numbering
ls docs/adr/ADR-*.md 2>/dev/null | wc -l
ls docs/decisions/*.md 2>/dev/null | wc -l
```

If no ADR directory exists, suggest creating `docs/adr/`.

### Step 4: Generate ADR

Determine the next ADR number (N+1) and generate the file.

## ADR Template (Michael Nygard Format)

```markdown
# ADR-[NNN]: [Decision Title]

**Date**: [YYYY-MM-DD]
**Status**: Proposed
**Author(s)**: [from git history]

## Context

[What is the issue that motivates this decision or change? Describe the forces at play — technical, business, organizational. This should be derived from actual code analysis and git history, not hypothetical.]

## Decision

[What is the change that we're making? Be specific about the technical approach chosen. Reference actual files and patterns implemented.]

## Consequences

### Positive
- [What becomes easier or better?]
- [What new capabilities does this enable?]

### Negative
- [What becomes harder or more complex?]
- [What are the trade-offs?]
- [What technical debt might this introduce?]

### Neutral
- [What changes without clear positive or negative impact?]

## Alternatives Considered

### [Alternative 1 Name]
- **Description**: [What would this approach look like?]
- **Rejected because**: [Why wasn't this chosen?]
- **Evidence**: [git history, reverts, or comments showing this was considered]

### [Alternative 2 Name]
- ...

## References

- [Relevant commit(s) with hashes]
- [Related PR(s) if available]
- [Related issues if found]
- [External documentation or RFCs if referenced in commits]
```

## File Naming

`ADR-YYYY-MM-DD-[kebab-case-title].md`

Example: `ADR-2026-04-14-switch-from-rest-to-graphql.md`

## Output

After generating the ADR content:
1. Display the full ADR in the chat
2. Offer to write it to `docs/adr/[filename]`
3. If `docs/adr/` doesn't exist, offer to create it

## Korean Output (--lang ko)

Translate section headers:
- "Context" → "맥락"
- "Decision" → "결정"
- "Consequences" → "결과"
- "Positive" → "긍정적"
- "Negative" → "부정적"
- "Neutral" → "중립적"
- "Alternatives Considered" → "검토한 대안"
- "References" → "참조"

Keep code references, file paths, and technical terms in English.