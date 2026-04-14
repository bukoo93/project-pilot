---
name: project-context
description: Provides ambient project awareness. Use when the user asks about project overview, what does this project do, explain this codebase, project health, tech stack, project status.
user-invocable: false
---

# Project Context Awareness

When triggered, provide quick project context:

1. **Manifest check**: Read package.json/pyproject.toml/Cargo.toml/go.mod
2. **README check**: Read README.md for project description
3. **Structure check**: List top-level directories
4. **Git activity**: Run `git log --oneline -10`
5. **File count**: Count source files by extension

## Output

```
## Project Overview
- **Name**: [from manifest]
- **Type**: [language/framework]
- **Size**: [~N source files]
- **Recent Activity**: [last commit]
- **Key Directories**: [with purposes]
```

References: [risk-scoring.md](references/risk-scoring.md), [output-formats.md](references/output-formats.md)
