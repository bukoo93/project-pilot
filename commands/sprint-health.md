---
description: "Analyze current sprint health: velocity, commit patterns, hotspots, risk areas, contributor activity"
argument-hint: "[--period 7d|14d|30d] [--team] [--lang ko]"
allowed-tools: ["Bash", "Read", "Glob", "Grep"]
---

# Sprint Health Dashboard

Generate a sprint health assessment from git metrics — velocity, commit patterns, hotspots, and risk indicators.

## Argument Parsing

Parse `$ARGUMENTS` for:
- **--period**: `7d`, `14d` (default), or `30d`
- **--team**: Include detailed per-contributor breakdown
- **--lang ko**: Output in Korean

## Workflow

### Step 1: Gather Raw Metrics

Run these git commands:

```bash
# Commit history for the period
git log --since="<period>" --no-merges --pretty=format:"%H|%s|%an|%ad" --date=short

# Line stats
git log --since="<period>" --no-merges --shortstat

# Files added
git log --since="<period>" --no-merges --diff-filter=A --name-only --pretty=format:"" | sort -u

# Files deleted
git log --since="<period>" --no-merges --diff-filter=D --name-only --pretty=format:"" | sort -u

# File change frequency (hotspots)
git log --since="<period>" --no-merges --name-only --pretty=format:"" | sort | uniq -c | sort -rn | head -20

# Commits per day
git log --since="<period>" --no-merges --format="%ad" --date=short | sort | uniq -c

# Commits by hour (work pattern)
git log --since="<period>" --no-merges --format="%ad" --date=format:"%H" | sort | uniq -c | sort -rn
```

### Step 2: Launch Contributor Analyzer (haiku, if --team)

If `--team` is specified, launch a haiku agent to provide per-contributor breakdown:
- Commits per contributor
- Files each contributor touched
- Primary working areas
- Knowledge concentration risks

### Step 3: Compute Metrics

Calculate:
- **Velocity**: Commits/day average, lines changed/day
- **Trend**: Compare first half vs second half of period (accelerating or decelerating?)
- **Hotspots**: Top 10 most-changed files (potential risk areas)
- **New vs Deleted**: Net file growth (project expanding or consolidating?)
- **Work Patterns**: Peak hours, off-hours work percentage (burnout indicator)
- **Branch Health**: `git branch -a --no-merged` count (stale branches)

### Step 4: Risk Assessment

Flag risks:
- **Hotspot + Complex**: Cross-reference top changed files with complexity (>300 LOC or deeply nested)
- **Single Contributor Area**: Files changed only by one person during the period
- **Late Acceleration**: If >60% of commits happened in the last 30% of the period
- **Off-Hours Spike**: If >30% of commits outside business hours (9am-6pm)
- **No Tests**: Changed source files with no corresponding test file changes

### Step 5: Format Dashboard

## Output Template

```markdown
## 📈 Sprint Health Dashboard
Period: [start] → [end] ([N days]) | Generated: [date]

---

### Velocity
| Metric | Value | Trend |
|--------|-------|-------|
| Total commits | N | - |
| Commits/day avg | N.N | ↑↓→ vs previous period |
| Lines added | +N | - |
| Lines removed | -N | - |
| Net change | +/-N | - |
| Files changed | N | - |
| Files added | N | - |
| Files deleted | N | - |

### Daily Activity
```
[Text-based sparkline or bar chart showing commits per day]
Mon: ████████ 12
Tue: ██████ 9
Wed: ████████████ 18
...
```

### Top 10 Hotspots
| # | File | Changes | Risk |
|---|------|---------|------|
| 1 | src/api/handler.ts | 15 changes | [HIGH] — complex file, single contributor |
| 2 | src/components/Form.tsx | 12 changes | [MEDIUM] — frequently changing UI |
| ... | ... | ... | ... |

### Risk Flags
- ⚠️ **[flag name]**: [description with evidence]
- ⚠️ **[flag name]**: [description with evidence]
- ✅ **[positive indicator]**: [description]

### Contributors (if --team)
| Contributor | Commits | Lines | Primary Areas | Status |
|-------------|---------|-------|---------------|--------|
| Alice | 45 | +1200/-300 | src/auth/, src/api/ | Active |
| Bob | 23 | +500/-150 | src/ui/ | Active |

### Action Items
1. **[Priority action]** — [specific recommendation based on data]
2. **[Priority action]** — [specific recommendation]
3. **[Priority action]** — [specific recommendation]
```

## Korean Output (--lang ko)

- "Sprint Health Dashboard" → "스프린트 건강도 대시보드"
- "Velocity" → "속도"
- "Daily Activity" → "일별 활동"
- "Hotspots" → "핫스팟"
- "Risk Flags" → "리스크 플래그"
- "Contributors" → "기여자"
- "Action Items" → "조치 항목"
- "Trend" → "추세"