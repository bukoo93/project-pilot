---
description: "Auto-generate release notes from git history since the last tag or specified ref"
argument-hint: "[since-ref] [--format changelog|narrative|bullet] [--include-breaking] [--lang ko]"
allowed-tools: ["Bash", "Read", "Glob", "Grep"]
disable-model-invocation: true
---

# Release Notes Generator

Generate structured release notes from git history. No sub-agents needed — this command operates directly on git data.

## Argument Parsing

Parse `$ARGUMENTS` for:
- **since-ref** (positional): Git ref (tag, branch, commit hash) to start from. Default: last tag.
- **--format**: `changelog` (default), `narrative`, or `bullet`
- **--include-breaking**: Include a dedicated breaking changes section
- **--lang ko**: Output in Korean

## Workflow

### Step 1: Determine Starting Point

```!
git describe --tags --abbrev=0 2>/dev/null || echo "NO_TAGS"
```

- If `$ARGUMENTS` contains a specific ref, use it
- If `NO_TAGS` returned and no ref specified, use the root commit: `git rev-list --max-parents=0 HEAD`
- Store the result as `SINCE_REF`

### Step 2: Gather Commit Data

Run these commands:
```bash
# All commits since ref
git log ${SINCE_REF}..HEAD --pretty=format:"%H|%s|%an|%ad" --date=short

# Stats summary
git diff --stat ${SINCE_REF}..HEAD | tail -1

# Files changed count
git diff --name-only ${SINCE_REF}..HEAD | wc -l

# Contributors
git log ${SINCE_REF}..HEAD --pretty=format:"%an" | sort -u
```

### Step 3: Categorize Commits

For each commit, categorize based on:

**Conventional Commits** (if project uses them):
- `feat:` / `feature:` → New Features
- `fix:` / `bugfix:` → Bug Fixes
- `perf:` → Performance Improvements
- `docs:` → Documentation
- `refactor:` → Refactoring
- `test:` → Tests
- `chore:` / `build:` / `ci:` → Maintenance
- `BREAKING CHANGE:` or `!:` → Breaking Changes

**Non-conventional commits** (analyze the message):
- Contains "add", "new", "create", "implement", "introduce" → New Features
- Contains "fix", "resolve", "patch", "correct", "bug" → Bug Fixes
- Contains "refactor", "clean", "restructure", "reorganize" → Refactoring
- Contains "perf", "optim", "speed", "fast", "cache" → Performance
- Contains "doc", "readme", "comment", "typo" → Documentation
- Contains "test", "spec", "coverage" → Tests
- Contains "update dep", "bump", "upgrade", "migrate" → Dependencies
- Otherwise → Other Changes

### Step 4: Generate Release Notes

#### Format: changelog (default)
```markdown
## [Unreleased] - YYYY-MM-DD

### ✨ New Features
- **[scope]**: description ([commit-hash-short])
- ...

### 🐛 Bug Fixes
- **[scope]**: description ([commit-hash-short])
- ...

### ⚡ Performance Improvements
- description ([commit-hash-short])

### 🔧 Refactoring
- description ([commit-hash-short])

### 📚 Documentation
- description ([commit-hash-short])

### 🧪 Tests
- description ([commit-hash-short])

### 🔨 Maintenance
- description ([commit-hash-short])

### ⚠️ Breaking Changes (if --include-breaking)
- description ([commit-hash-short])

---
**Stats**: N commits, N files changed, +N/-N lines
**Contributors**: name1, name2, name3
**Compared to**: SINCE_REF
```

#### Format: narrative
```markdown
## Release Summary

[2-3 paragraph prose summary of what changed, written for non-technical stakeholders]

### Highlights
- [Most important change 1]
- [Most important change 2]
- [Most important change 3]

### Details
[Grouped by theme rather than commit type, in flowing prose]

---
N commits by N contributors since SINCE_REF
```

#### Format: bullet
```markdown
## Changes since SINCE_REF

**Features**
- item
- item

**Fixes**
- item

**Other**
- item

---
N commits | N contributors | +N/-N lines
```

## Korean Output (--lang ko)

If `--lang ko`:
- "New Features" → "신규 기능"
- "Bug Fixes" → "버그 수정"
- "Performance Improvements" → "성능 개선"
- "Refactoring" → "리팩토링"
- "Documentation" → "문서"
- "Tests" → "테스트"
- "Maintenance" → "유지보수"
- "Breaking Changes" → "호환성 파괴 변경"
- "Release Summary" → "릴리즈 요약"
- "Contributors" → "기여자"
- "Stats" → "통계"
- Narrative prose also in Korean