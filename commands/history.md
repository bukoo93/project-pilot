---
description: "Explain why code was written a certain way using git history, blame, and related commits"
argument-hint: "<file-path-or-function> [--depth deep|shallow] [--lang ko]"
allowed-tools: ["Bash", "Read", "Glob", "Grep"]
---

# History Explanation

Reconstruct the decision context behind a file or function — explain **why** the code exists in its current form using git archaeology.

## Argument Parsing

Parse `$ARGUMENTS` for:
- **target** (required): A file path (e.g., `src/auth/login.ts`) or a function name (e.g., `processPayment`)
- **--depth**: `shallow` (last 5 changes, default) or `deep` (full history, related PRs, co-changed files)
- **--lang ko**: Output in Korean

If no argument is provided, ask the user to specify a file or function.

## Workflow

### Step 1: Resolve Target

- If the target looks like a file path (contains `/` or `.`), verify it exists with Glob
- If the target is a function/class name, use Grep to locate it in the codebase
- If multiple locations found, list them and ask the user to pick one (or analyze all)

### Step 2: Launch Git Archaeologist Agent (sonnet)

Prompt the agent with the resolved file path and depth level.

**For shallow analysis**, instruct the agent to:
- Run `git log --follow -5 --pretty=format:"%H|%s|%an|%ad|%b" --date=short -- <file>`
- Run `git blame -w -C -C -C <file>` for per-line attribution
- Build a brief timeline of recent decisions
- Provide a 1-paragraph decision narrative

**For deep analysis**, additionally instruct the agent to:
- Run full `git log --follow --all` for complete history
- For each significant commit, check co-changed files: `git show <hash> --name-only`
- Search for related PRs: `gh pr list --search "<hash>" --state merged 2>/dev/null`
- Check for reverts: `git log --all --grep="revert" -- <file>`
- Look for linked issues in commit messages
- Provide full narrative and change metrics

### Step 3: Format Output

Use the Git Archaeologist's output and format it.

## Output Template

```markdown
## 🔍 Code History: [target]

### Quick Context
> [1-2 sentence summary: what this code does and the key decision behind it]

### Decision Timeline
[Chronological list of significant changes with "why" explanations]

### Narrative
[Connected story of how this code evolved — for deep mode, include related decisions in other files]

### Key Takeaways
1. [Primary insight]
2. [Secondary insight]
3. [Current state assessment]

### Metrics
| Metric | Value |
|--------|-------|
| Total commits | N |
| Contributors | N (names) |
| Age | [first commit date] |
| Last changed | [date] |
| Churn | [high/medium/low] |
```

## Korean Output (--lang ko)

- "Code History" → "코드 히스토리"
- "Quick Context" → "핵심 맥락"
- "Decision Timeline" → "의사결정 타임라인"
- "Narrative" → "변경 이야기"
- "Key Takeaways" → "핵심 시사점"
- "Metrics" → "지표"