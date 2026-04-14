---
description: "Identify knowledge concentration risks: files and modules with single-contributor dependency"
argument-hint: "[--period 6m|1y|all] [--lang ko]"
allowed-tools: ["Bash", "Read", "Glob", "Grep"]
---

# Bus Factor Analysis

Identify knowledge concentration risks — areas of the codebase where too few people understand the code.

## Argument Parsing

Parse `$ARGUMENTS` for:
- **--period**: `6m` (last 6 months), `1y` (last year), or `all` (full history, default)
- **--lang ko**: Output in Korean

## Workflow

### Step 1: Gather File Ownership Data

```bash
# List all source files (exclude generated/vendor)
find . -type f \( -name "*.ts" -o -name "*.tsx" -o -name "*.js" -o -name "*.jsx" -o -name "*.py" -o -name "*.go" -o -name "*.rs" -o -name "*.java" -o -name "*.rb" -o -name "*.php" -o -name "*.cs" \) -not -path "*/node_modules/*" -not -path "*/vendor/*" -not -path "*/.git/*" -not -path "*/dist/*" -not -path "*/build/*" -not -path "*/__pycache__/*"
```

For each file (or sample if >500 files):
```bash
# Unique contributors to this file
git log --all --no-merges --pretty=format:"%an" [--since="<period>"] -- <file> | sort -u

# Primary contributor percentage
git log --all --no-merges --pretty=format:"%an" [--since="<period>"] -- <file> | sort | uniq -c | sort -rn | head -1
```

### Step 2: Launch Contributor Analyzer Agent (haiku)

Instruct the agent to:
- Compute bus factor per file (unique contributors)
- Identify files where primary contributor owns >80% of commits
- Group results by directory/module
- Cross-reference with file importance (how many other files import it)
- Check if primary contributors are still active (committed in last 90 days)
- Calculate project-level bus factor

### Step 3: Cross-Reference with Importance

Determine which bus-factor-1 files are actually critical:
```bash
# How many files import this file? (importance indicator)
grep -rl "<filename>" --include="*.ts" --include="*.js" --include="*.py" src/ 2>/dev/null | wc -l
```

A bus-factor-1 file that's imported by 20 other files = CRITICAL risk.
A bus-factor-1 utility used by 1 file = LOW risk.

### Step 4: Format Report

## Output Template

```markdown
## 🚌 Bus Factor Analysis
Period: [period] | Generated: [date]

---

### Project-Level Bus Factor: [N]

> [Explanation: "If [N] specific people left, more than 50% of the codebase would have no knowledgeable maintainer"]

### Overview

| Metric | Value |
|--------|-------|
| Total source files analyzed | N |
| Files with bus factor 1 | N (N%) |
| Files with bus factor 2 | N (N%) |
| Files with bus factor 3+ | N (N%) |
| Critical single-owner files | N |

### Critical Risk Areas

Files with bus factor 1 AND high importance (many dependents):

| File | Sole Owner | Owner Active? | Dependents | Risk |
|------|-----------|---------------|------------|------|
| `src/auth/session.ts` | Alice | ✅ Active | 12 files | [HIGH] |
| `src/data/migration.ts` | Charlie | ❌ Inactive (4mo) | 8 files | [CRITICAL] |

### Knowledge Distribution by Module

| Module | Contributors | Primary Owner | Ownership % | Bus Factor |
|--------|-------------|---------------|-------------|------------|
| src/auth/ | 2 | Alice | 91% | 1 |
| src/api/ | 4 | Bob | 45% | 3 |
| src/ui/ | 3 | Bob | 62% | 2 |
| src/data/ | 1 | Charlie | 100% | 1 |

### Knowledge Heat Map (Text)

```
[Directory-based view showing risk levels]
src/
├── auth/    [██████████] 🔴 Bus Factor: 1 (Alice 91%)
├── api/     [████░░░░░░] 🟢 Bus Factor: 3 (distributed)
├── ui/      [██████░░░░] 🟡 Bus Factor: 2 (Bob 62%)
├── data/    [██████████] 🔴 Bus Factor: 1 (Charlie 100%, INACTIVE)
└── utils/   [███░░░░░░░] 🟢 Bus Factor: 4 (well distributed)
```

### Recommendations

1. **Immediate**: [Pair programming or code review targets for critical areas]
2. **Short-term**: [Knowledge sharing sessions for high-risk modules]
3. **Ongoing**: [Documentation priorities, rotation suggestions]
```

## Korean Output (--lang ko)

- "Bus Factor Analysis" → "버스 팩터 분석"
- "Critical Risk Areas" → "핵심 리스크 영역"
- "Knowledge Distribution" → "지식 분포"
- "Knowledge Heat Map" → "지식 히트맵"
- "Sole Owner" → "단독 소유자"
- "Owner Active?" → "소유자 활동 중?"
- "Active" → "활동 중"
- "Inactive" → "비활동"