---
description: "Detect potential breaking changes between two refs (tags, branches, commits)"
argument-hint: "<from-ref> <to-ref> [--lang ko]"
allowed-tools: ["Bash", "Read", "Glob", "Grep"]
---

# Breaking Change Detection

Compare two git refs and identify potential breaking changes — removed exports, changed signatures, schema modifications, new required configs.

## Argument Parsing

Parse `$ARGUMENTS` for:
- **from-ref** (required): Starting git ref (tag, branch, or commit hash)
- **to-ref** (optional): Ending git ref (default: `HEAD`)
- **--lang ko**: Output in Korean

If no from-ref is specified, use the last tag: `git describe --tags --abbrev=0 2>/dev/null`

## Workflow

### Step 1: Gather Changed Files

```bash
# List all changed files between refs
git diff <from-ref>..<to-ref> --name-only --diff-filter=ADMR

# Stats summary
git diff <from-ref>..<to-ref> --stat | tail -5

# Deleted files (definitely breaking if exported)
git diff <from-ref>..<to-ref> --name-only --diff-filter=D

# Renamed files (potentially breaking)
git diff <from-ref>..<to-ref> --name-only --diff-filter=R
```

### Step 2: Launch Change Impact Analyzer Agent (sonnet)

Instruct the agent to analyze the diff for breaking change patterns:

#### A. API Surface Changes
- Removed exports (functions, classes, types, constants)
- Renamed exports
- Changed function signatures (added required params, changed return types)
- Changed response shapes (API endpoints)

#### B. Schema Changes
- Database migration files that drop columns/tables
- Changed model/entity definitions
- Changed TypeScript interfaces that are exported
- GraphQL schema changes (removed fields/types)
- Protobuf schema changes

#### C. Configuration Changes
- New required environment variables (in .env.example or config templates)
- Changed config file shapes
- Changed build configuration

#### D. Dependency Breaking
- Major version bumps in dependencies
- Removed dependencies that might affect consumers
- Changed peer dependency requirements

#### E. Behavioral Changes
- Changed default values
- Changed error handling (different error types/messages)
- Changed event names or payloads

### Step 3: Categorize Findings

For each finding, classify as:
- **Definitely Breaking** 🔴: Removed exports, removed required fields, deleted files that were imported
- **Likely Breaking** 🟠: Changed signatures, new required params, type changes
- **Possibly Breaking** 🟡: Changed defaults, behavioral changes, renamed with aliases
- **Safe** 🟢: Additions only, internal refactoring, test-only changes

### Step 4: Format Report

## Output Template

```markdown
## ⚠️ Breaking Change Detection
Comparing: [from-ref] → [to-ref]
Generated: [date]

---

### Summary

| Category | Count |
|----------|-------|
| 🔴 Definitely Breaking | N |
| 🟠 Likely Breaking | N |
| 🟡 Possibly Breaking | N |
| 🟢 Safe Changes | N |
| **Total changed files** | **N** |

### 🔴 Definitely Breaking

#### 1. [Description]
- **File**: `path/to/file.ts:line`
- **What changed**: [Specific change]
- **Impact**: [What breaks]
- **Migration**: [How to fix consumers]

#### 2. ...

### 🟠 Likely Breaking

#### 1. [Description]
- **File**: `path/to/file.ts:line`
- **What changed**: [Specific change]
- **Impact**: [What might break]
- **Migration**: [Suggested fix]

### 🟡 Possibly Breaking
[Similar format, briefer]

### Migration Guide

If there are breaking changes, generate a brief migration guide:

```markdown
## Migrating from [from-ref] to [to-ref]

### Step 1: [Action]
[Instructions]

### Step 2: [Action]
[Instructions]
```

---

**Files analyzed**: N | **Commits**: N
```

## Korean Output (--lang ko)

- "Breaking Change Detection" → "호환성 파괴 변경 감지"
- "Definitely Breaking" → "확실한 파괴 변경"
- "Likely Breaking" → "파괴 가능성 높음"
- "Possibly Breaking" → "파괴 가능성 있음"
- "Safe Changes" → "안전한 변경"
- "Migration Guide" → "마이그레이션 가이드"
- "What changed" → "변경 내용"
- "Impact" → "영향"
- "Migration" → "대응 방법"