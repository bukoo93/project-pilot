---
name: project-context
description: Provides ambient project awareness. Use when the user asks about "project overview", "what does this project do", "explain this codebase", "project health", "tech stack", "project status", or any general questions about the current repository's structure, technology, or health.
user-invocable: false
---

# Project Context Awareness

When triggered, provide quick project context by performing a lightweight scan:

## Quick Scan Steps

1. **Manifest check**: Read the primary manifest file (package.json, pyproject.toml, Cargo.toml, go.mod, pom.xml, Gemfile, composer.json) to identify the tech stack.
2. **README check**: Read README.md (if exists) for project description and purpose.
3. **Structure check**: List top-level directories to understand project organization.
4. **Git activity**: Run `git log --oneline -10` to see recent activity.
5. **File count**: Run `find . -type f -name "*.{ts,js,py,go,rs,java,rb,php,cs}" | wc -l` (adjust extension by detected language) to gauge project size.

## Output Format

Provide a concise summary in this structure:

```
## Project Overview
- **Name**: [from manifest or directory name]
- **Type**: [language/framework]
- **Size**: [~N source files]
- **Recent Activity**: [last commit date and summary]
- **Key Directories**: [src/, lib/, tests/, etc. with purposes]
```

## Reference Materials

- Risk scoring methodology: [risk-scoring.md](references/risk-scoring.md)
- Output format standards: [output-formats.md](references/output-formats.md)