---
description: "Generate a comprehensive PM dashboard combining project health, velocity, debt, and risk metrics"
argument-hint: "[--period 14d|30d] [--lang ko]"
allowed-tools: ["Bash", "Read", "Glob", "Grep"]
---

# PM Dashboard

A single-page project health overview combining velocity, technical debt, bus factor, and risk metrics. This is the orchestrator command that pulls lightweight data from multiple analysis areas.

## Argument Parsing

Parse `$ARGUMENTS` for:
- **--period**: `14d` (default) or `30d`
- **--lang ko**: Output in Korean

## Workflow

### Step 1: Gather Core Metrics (Direct — no agents needed for basic stats)

Run these commands in parallel:

```bash
# Velocity stats
git log --since="<period>" --no-merges --oneline | wc -l
git log --since="<period>" --no-merges --shortstat | grep "files changed" | tail -1

# Active contributors
git shortlog -sn --no-merges --since="<period>"

# Hotspot files (top 10 most changed)
git log --since="<period>" --no-merges --name-only --pretty=format:"" | sort | uniq -c | sort -rn | head -10

# Branch health
git branch --no-merged 2>/dev/null | wc -l

# Last tag distance
git describe --tags --long 2>/dev/null || echo "no tags"

# Recent velocity trend (this week vs last week)
git log --since="7 days ago" --no-merges --oneline | wc -l
git log --since="14 days ago" --until="7 days ago" --no-merges --oneline | wc -l
```

### Step 2: Launch 3 Lightweight Agents in Parallel

#### Agent A: Debt Quick Scan (haiku)
Quick scan for critical debt only:
- Count TODO/FIXME/HACK comments
- Find files >500 lines
- Check `npm outdated 2>/dev/null | wc -l` or equivalent

#### Agent B: Bus Factor Quick Check (haiku)
Quick bus factor assessment:
- For top 10 hotspot files, check unique contributors
- Identify any critical single-owner files

#### Agent C: Risk Flag Scanner (haiku)
Quick risk assessment:
- Check for uncommitted changes: `git status --short`
- Check for merge conflicts: `git diff --check HEAD`
- Check for failing CI (if `gh` available): `gh run list --limit 3`
- Check for open security advisories: `npm audit --json 2>/dev/null | head -5`

### Step 3: Compute Health Score

Calculate a composite project health score (0-100):

| Component | Weight | Scoring |
|-----------|--------|--------|
| Velocity consistency | 20% | Stable or growing = 20, declining significantly = 5 |
| Bus factor | 20% | BF >= 3 = 20, BF = 2 = 12, BF = 1 = 5 |
| Tech debt density | 20% | <5 critical items = 20, 5-10 = 12, >10 = 5 |
| Dependency health | 15% | All current = 15, minor outdated = 10, major outdated = 5, CVEs = 0 |
| Test presence | 15% | Tests exist + pass = 15, tests exist = 10, no tests = 0 |
| CI status | 10% | Passing = 10, failing = 3, no CI = 5 |

### Step 4: Format Dashboard

## Output Template

```markdown
## 📊 Project Dashboard
Period: [start] → [end] | Generated: [date]

═══════════════════════════════════════════════════
  PROJECT HEALTH SCORE: [NN] / 100  [emoji indicator]
═══════════════════════════════════════════════════

### ⚡ Velocity
| Metric | This Period | Trend |
|--------|------------|-------|
| Commits | N | ↑↓→ |
| Lines changed | +N / -N | - |
| Active contributors | N | - |
| Files touched | N | - |

Daily activity:
```
Mon ████████ 8
Tue ██████████████ 14
Wed ████████████ 12
Thu ██████ 6
Fri ████████████████ 16
```

### 🔥 Hotspots (Most Changed Files)
| # | File | Changes | Owner | Risk |
|---|------|---------|-------|------|
| 1 | ... | N | ... | ... |
| 2 | ... | N | ... | ... |
| 3 | ... | N | ... | ... |

### 🔍 Top Risks
| # | Risk | Category | Severity |
|---|------|----------|----------|
| 1 | [description] | [debt/bus-factor/security/ci] | [CRITICAL/HIGH] |
| 2 | [description] | [...] | [...] |
| 3 | [description] | [...] | [...] |

### 📦 Dependencies
- Outdated: N packages (N major, N minor)
- Security: N advisories
- Status: [Healthy ✅ / Needs attention ⚠️ / At risk 🔴]

### 🚌 Bus Factor: [N]
- Single-owner critical files: N
- Knowledge concentration: [description]

### 📋 Action Items
1. **[Priority 1]** — [specific, actionable recommendation]
2. **[Priority 2]** — [specific, actionable recommendation]
3. **[Priority 3]** — [specific, actionable recommendation]

---
> Run `/project-pilot:debt` for full technical debt report
> Run `/project-pilot:sprint-health --team` for detailed team metrics
> Run `/project-pilot:bus-factor` for knowledge risk details
```

## Health Score Emoji

| Score | Emoji | Status |
|-------|-------|--------|
| 80-100 | 🟢 | Excellent |
| 60-79 | 🟡 | Good, minor attention needed |
| 40-59 | 🟠 | Needs attention |
| 0-39 | 🔴 | At risk, action required |

## Korean Output (--lang ko)

- "Project Dashboard" → "프로젝트 대시보드"
- "PROJECT HEALTH SCORE" → "프로젝트 건강 점수"
- "Velocity" → "개발 속도"
- "Hotspots" → "핫스팟"
- "Top Risks" → "주요 리스크"
- "Dependencies" → "의존성"
- "Bus Factor" → "버스 팩터"
- "Action Items" → "조치 항목"