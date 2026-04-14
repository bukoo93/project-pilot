# Risk Scoring Methodology

Used across all Project Pilot commands for consistent risk assessment.

## Formula

```
Risk Score = (Severity × Likelihood × Age_Multiplier × Centrality_Multiplier)
             normalized to 1-10 scale
```

## Dimensions

### Severity (1-4)
How bad is it if this goes wrong?

| Score | Level | Description |
|-------|-------|-------------|
| 1 | Cosmetic | No functional impact. Style, naming, minor inconsistencies |
| 2 | Minor | Limited impact. Affects edge cases or non-critical paths |
| 3 | Major | Significant impact. Affects core functionality or multiple users |
| 4 | Critical | System-wide impact. Data loss, security breach, or total failure possible |

### Likelihood (1-4)
How likely is it to cause problems?

| Score | Level | Description |
|-------|-------|-------------|
| 1 | Unlikely | Requires unusual conditions to trigger |
| 2 | Possible | Could happen under normal usage |
| 3 | Likely | Will probably happen during regular use |
| 4 | Certain | Already causing issues or guaranteed to on next change |

### Age Multiplier (1.0-2.0)
How old is the technical debt?

| Age | Multiplier | Rationale |
|-----|-----------|----------|
| < 1 month | 1.0 | Recently introduced, easy context recall |
| 1-3 months | 1.2 | Context still fresh |
| 3-6 months | 1.4 | Context fading |
| 6-12 months | 1.6 | Original author may have moved on |
| > 12 months | 1.8 | Deep legacy, high context-switch cost |
| > 24 months | 2.0 | Fossilized debt, may require archaeology to understand |

### Centrality Multiplier (1.0-2.0)
How central is the affected code?

| Centrality | Multiplier | Description |
|-----------|-----------|-------------|
| Leaf | 1.0 | Utility, helper, or isolated module |
| Branch | 1.2 | Used by a few modules |
| Trunk | 1.5 | Core business logic or shared service |
| Root | 1.8 | Entry point, config, or infrastructure |
| Backbone | 2.0 | Auth, database layer, API gateway, or build system |

## Normalization

Raw score = Severity × Likelihood × Age × Centrality
- Min possible = 1 × 1 × 1.0 × 1.0 = 1.0
- Max possible = 4 × 4 × 2.0 × 2.0 = 64.0

Normalized = ceil((Raw / 64) × 10), clamped to [1, 10]

## Risk Categories

| Score | Category | Badge | Badge (Korean) | Action |
|-------|----------|-------|----------------|--------|
| 9-10 | Critical | `[CRITICAL]` | `[심각]` | Immediate action required |
| 7-8 | High | `[HIGH]` | `[높음]` | Plan remediation this sprint |
| 4-6 | Medium | `[MEDIUM]` | `[중간]` | Schedule for next quarter |
| 1-3 | Low | `[LOW]` | `[낮음]` | Monitor, address opportunistically |