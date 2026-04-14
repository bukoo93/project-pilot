---
name: code-history
description: "Explain why code was written using git history. Use when: 왜 이렇게 짰어, 이 코드 왜 이래, why was this written, code history, 변경 이력, change history, 이 파일 히스토리, who wrote this, 의사결정 맥락, decision context, git blame, 코드 배경"
tools: Bash, Read, Glob, Grep
---

# Code History (Keyword-Triggered)

1. Identify target file/function from user's message
2. Launch sonnet agent (git-archaeologist) for git log, blame, decision context
3. Output: Quick Context, Decision Timeline, Narrative, Key Takeaways
