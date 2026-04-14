---
description: "Analyze internal and external dependencies — circular deps, outdated packages, security vulnerabilities, coupling metrics"
argument-hint: "[--type internal|external|all] [--lang ko]"
allowed-tools: ["Bash", "Read", "Glob", "Grep"]
---

# Dependency Analysis

Comprehensive dependency analysis covering both internal module dependencies and external packages.

## Argument Parsing

Parse `$ARGUMENTS` for:
- **--type**: `internal` (module graph only), `external` (packages only), or `all` (default)
- **--lang ko**: Output in Korean

## Workflow

### Step 1: Launch Dependency Mapper Agent (sonnet)

Based on `--type`, instruct the agent:

#### For internal analysis:
- Scan all source files for import/require statements
- Build a module-to-module dependency graph
- Calculate coupling metrics (fan-in, fan-out, instability) per module
- Detect circular dependencies
- Check for boundary violations (reaching into module internals)

#### For external analysis:
- Read manifest files for direct and dev dependencies
- Run `${CLAUDE_PLUGIN_ROOT}/scripts/check-outdated-deps.sh` for outdated check
- Count per-package usage (how many source files import each package)
- Identify heavily-coupled external packages
- Run security audit if available (npm audit / pip audit / cargo audit)

### Step 2: Format Report

## Output Template

```markdown
## 🔗 Dependency Analysis
Generated: [date] | Type: [all/internal/external]

---

### Internal Module Graph

#### Coupling Metrics
| Module | Fan-in | Fan-out | Instability | Health |
|--------|--------|---------|-------------|--------|
| src/auth/ | 8 | 3 | 0.27 | ✅ Stable |
| src/api/ | 2 | 9 | 0.82 | ⚠️ Unstable |

#### Circular Dependencies
[List or "None found ✅"]

#### Dependency Graph
```
[Text-based module dependency graph]
```

### External Package Health

#### Overview
| Metric | Count |
|--------|-------|
| Direct dependencies | N |
| Dev dependencies | N |
| Outdated (minor) | N |
| Outdated (major) | N |
| Security vulnerabilities | N |

#### Outdated Packages
| Package | Current | Latest | Gap | Priority |
|---------|---------|--------|-----|----------|
| ... | ... | ... | major/minor/patch | HIGH/LOW |

#### Security Advisories
[From audit output, or "No known vulnerabilities ✅"]

#### Heavily Coupled Packages
| Package | Files Using | Migration Cost |
|---------|------------|----------------|
| ... | N files | HIGH/MEDIUM/LOW |

### Recommendations
1. [Prioritized action items]
```

## Korean Output (--lang ko)

- "Dependency Analysis" → "의존성 분석"
- "Internal Module Graph" → "내부 모듈 그래프"
- "Coupling Metrics" → "결합도 지표"
- "Circular Dependencies" → "순환 의존성"
- "External Package Health" → "외부 패키지 건강도"
- "Outdated Packages" → "오래된 패키지"
- "Security Advisories" → "보안 경고"
- "Heavily Coupled Packages" → "강결합 패키지"