---
description: "Analyze blast radius of changes to a file, function, or module — dependents, test coverage, co-change partners"
argument-hint: "<file-or-function> [--depth 1|2|3] [--lang ko]"
allowed-tools: ["Bash", "Read", "Glob", "Grep"]
---

# Impact Analysis

Determine the blast radius of changes to a specific file, function, or module.

## Argument Parsing

Parse `$ARGUMENTS` for:
- **target** (required): A file path (e.g., `src/auth/login.ts`) or function/class name (e.g., `processPayment`)
- **--depth**: How many levels of transitive dependencies to trace. `1` (direct only), `2` (default), `3` (deep)
- **--lang ko**: Output in Korean

If no target specified, ask the user.

## Workflow

### Step 1: Resolve Target

- If it looks like a file path (contains `/` or `.`), verify with Glob
- If it's a function/class name, Grep for it and identify the primary file
- If multiple matches, list them and ask the user

### Step 2: Launch Two Agents in Parallel

#### Agent A: Change Impact Analyzer (sonnet)
Instruct to:
- Find direct dependents (files importing/referencing the target)
- Trace transitive dependents up to specified depth
- Find test files covering the target
- Check config/build references
- Perform git co-change analysis (files historically changed together)
- Assess risk level

#### Agent B: Dependency Mapper (sonnet)
Instruct to:
- Map the target's position in the internal dependency graph
- Calculate fan-in (how many things depend on target)
- Calculate fan-out (what target depends on)
- Check for circular dependencies involving the target

### Step 3: Combine Results

Merge both agents' outputs into a unified impact report.

## Output Template

```markdown
## 💥 Impact Analysis: [target]
Generated: [date] | Depth: [depth]

---

### Blast Radius Summary

| Metric | Count |
|--------|-------|
| Direct dependents | N |
| Transitive dependents (depth N) | N |
| Test files | N |
| Config references | N |
| Co-change partners | N |
| **Total affected scope** | **N files** |

### Risk Level: [CRITICAL/HIGH/MEDIUM/LOW]
> [1-2 sentence explanation of why this risk level]

### Dependency Rings

[Ring diagram showing target at center, dependents in rings]

### Ring 1 — Direct Dependents
| File | Dependency Type | Has Tests |
|------|----------------|----------|
| ... | imports X() | ✅/❌ |

### Ring 2+ — Transitive Dependents
| File | Through | Has Tests |
|------|---------|----------|
| ... | via file.ts | ✅/❌ |

### Test Coverage
[Which tests cover this, coverage gaps]

### Implicit Coupling (Co-Change Partners)
[Files that historically change together with the target]

### Safe Change Checklist
- [ ] Update [file1] — [reason]
- [ ] Update [file2] — [reason]
- [ ] Run tests in [test-file1]
- [ ] Verify [config] still valid
```

## Korean Output (--lang ko)

- "Impact Analysis" → "영향도 분석"
- "Blast Radius Summary" → "영향 범위 요약"
- "Risk Level" → "리스크 수준"
- "Direct dependents" → "직접 의존 파일"
- "Transitive dependents" → "간접 의존 파일"
- "Test Coverage" → "테스트 커버리지"
- "Implicit Coupling" → "암묵적 결합"
- "Safe Change Checklist" → "안전한 변경 체크리스트"