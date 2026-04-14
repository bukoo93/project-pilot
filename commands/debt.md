---
description: "Scan codebase for technical debt: complex functions, stale TODOs, outdated dependencies, dead code, with risk scores"
argument-hint: "[scope: full|src|path/to/dir] [--threshold low|medium|high] [--lang ko]"
allowed-tools: ["Bash", "Read", "Glob", "Grep"]
---

# Technical Debt Report

Scan the codebase for technical debt and produce a PM-friendly report with risk scores.

## Argument Parsing

Parse `$ARGUMENTS` for:
- **scope** (positional): `full` (default), `src`, or a specific directory path
- **--threshold**: Minimum risk level to report. `low` (show all), `medium` (4+ only, default), `high` (7+ only)
- **--lang ko**: Output in Korean

## Workflow

### Step 1: Scope Resolution
- If `full` or empty → scan the entire project (excluding node_modules, vendor, dist, build, .git)
- If `src` → scan only `src/` directory
- If a specific path → verify it exists and scan that directory

### Step 2: Launch Debt Scanner Agent (sonnet)

Prompt the agent with the scope and instruct it to perform 5 scan categories:

1. **Complexity Hotspots**: Long files (>500 LOC), deeply nested functions, many parameters, high branch count
2. **Stale TODOs**: All TODO/FIXME/HACK comments cross-referenced with `git blame` for age
3. **Outdated Dependencies**: Run `${CLAUDE_PLUGIN_ROOT}/scripts/check-outdated-deps.sh`
4. **Dead Code Indicators**: Commented-out code blocks, unused exports (heuristic)
5. **Code Smells**: God files, inconsistent patterns, magic values

For each finding, the agent must calculate a risk score (1-10) using:
- Severity (1-4) × Likelihood (1-4) × Age multiplier (1.0-2.0) × Centrality multiplier (1.0-2.0)
- Normalized to 1-10 scale

Centrality is determined by counting how many files import/reference the affected file.

### Step 3: Filter by Threshold
- `--threshold low`: Show all findings (score >= 1)
- `--threshold medium` (default): Show findings with score >= 4
- `--threshold high`: Show findings with score >= 7

### Step 4: Format Report

## Output Template

```markdown
## 🔍 Technical Debt Report
Generated: [date] | Scope: [scope] | Threshold: [threshold]

---

### Executive Summary

> **Total items**: N findings across 5 categories
> **Distribution**: N critical, N high, N medium, N low
> **Top risk area**: [directory or module with most debt]
> **Recommended focus**: [1-sentence action recommendation]

### Top 10 Riskiest Items

| # | Score | Category | Location | Description | Age | Action |
|---|-------|----------|----------|-------------|-----|--------|
| 1 | 9/10 [CRITICAL] | Complexity | `src/auth.ts:45` | processLogin() — 15 branches, 8 levels deep | 14mo | Decompose into sub-functions |
| 2 | 8/10 [HIGH] | TODO | `src/api/handler.ts:123` | "FIXME: race condition" | 8mo | Fix concurrency issue |
| ... | ... | ... | ... | ... | ... | ... |

### Category Details

#### 🧩 Complexity Hotspots (N items)
[List with file:line, metric details, and why it's a problem]

#### 📝 Stale TODOs (N items)
[List with file:line, age, original author, TODO text]

#### 📦 Outdated Dependencies (N items)
[List with package name, current version, latest version, gap]

#### 💀 Dead Code (N indicators)
[List with file:line and evidence]

#### 🔧 Code Smells (N items)
[List with file:line and description]

---

### Recommended Action Plan

#### This Sprint (Critical + High)
1. [Specific action with file reference]
2. [Specific action with file reference]
3. [Specific action with file reference]

#### Next Sprint
- [Grouped medium-priority items]

#### Backlog
- [Low-priority items grouped by theme]

---

**Methodology**: Risk scores use Severity × Likelihood × Age × Centrality formula.
See risk-scoring reference for full methodology.
```

## Korean Output (--lang ko)

- "Technical Debt Report" → "기술 부채 리포트"
- "Executive Summary" → "핵심 요약"
- "Top 10 Riskiest Items" → "리스크 상위 10개 항목"
- "Category Details" → "카테고리별 상세"
- "Complexity Hotspots" → "복잡도 핫스팟"
- "Stale TODOs" → "방치된 TODO"
- "Outdated Dependencies" → "오래된 의존성"
- "Dead Code" → "죽은 코드"
- "Code Smells" → "코드 스멜"
- "Recommended Action Plan" → "권장 조치 계획"
- "This Sprint" → "이번 스프린트"
- "Next Sprint" → "다음 스프린트"
- "Backlog" → "백로그"