---
name: code-history
description: "Explain why code was written a certain way using git history and blame. Use when the user asks: 왜 이렇게 짰어, 이 코드 왜 이래, why was this written, why is this code like this, 코드 히스토리, code history, 변경 이력, change history, 이 파일 히스토리, explain this code's history, 누가 이거 만들었어, who wrote this, 의사결정 맥락, decision context, git blame, 이 코드 배경이 뭐야"
tools: Bash, Read, Glob, Grep
---

# Code History Explanation (Keyword-Triggered)

The user is asking about the history or rationale behind specific code. Use git archaeology to explain **why**, not just **what**.

## Detect Target

From the user's message, identify:
1. A specific file path (if mentioned)
2. A function/class name (if mentioned)
3. A code snippet or concept (if vague)

If no specific target:
- Ask the user which file or function they want to understand
- Or if they're looking at a file in context, use that

## Detect Language Preference

- Korean message → Korean output
- English message → English output

## Workflow

1. **Resolve target**: Use Grep/Glob to find the exact file
2. **Launch sonnet agent** (as git-archaeologist) to:
   - Run `git log --follow -10 --pretty=format:"%H|%s|%an|%ad|%b" --date=short -- <file>`
   - Run `git blame -w -C -C -C <file>` (or specific lines)
   - Extract decision context from commit messages
   - Find related issues/PRs (patterns: #123, fixes #, closes #)
   - Build a narrative timeline

## Output Format

```markdown
## 🔍 [File/Function] History

### Quick Context
> [1-2 sentence: what this code does and the key decision behind it]

### Decision Timeline
[Chronological changes with "why" explanations]

### Narrative
[Connected story of how this code evolved]

### Key Takeaways
1. [Primary insight]
2. [Current state assessment]
```