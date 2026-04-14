# Risk Scoring Methodology

## Formula

```
Risk Score = Severity(1-4) x Likelihood(1-4) x Age(1.0-2.0) x Centrality(1.0-2.0)
Normalized to 1-10 scale
```

## Dimensions

### Severity (1-4)
| Score | Level | Description |
|-------|-------|-------------|
| 1 | Cosmetic | No functional impact |
| 2 | Minor | Limited impact, edge cases |
| 3 | Major | Core functionality affected |
| 4 | Critical | System-wide, data loss possible |

### Likelihood (1-4)
| Score | Level | Description |
|-------|-------|-------------|
| 1 | Unlikely | Unusual conditions |
| 2 | Possible | Normal usage |
| 3 | Likely | Regular use |
| 4 | Certain | Already causing issues |

### Age Multiplier (1.0-2.0)
| Age | Multiplier |
|-----|----------|
| < 1 month | 1.0 |
| 1-3 months | 1.2 |
| 3-6 months | 1.4 |
| 6-12 months | 1.6 |
| > 12 months | 1.8 |
| > 24 months | 2.0 |

### Centrality Multiplier (1.0-2.0)
| Centrality | Multiplier | Description |
|-----------|-----------|-------------|
| Leaf | 1.0 | Utility, isolated |
| Branch | 1.2 | Used by few modules |
| Trunk | 1.5 | Core business logic |
| Root | 1.8 | Entry point, config |
| Backbone | 2.0 | Auth, DB, API gateway |

## Risk Categories

| Score | Category | Badge | Badge (KO) |
|-------|----------|-------|------------|
| 9-10 | Critical | `[CRITICAL]` | `[심각]` |
| 7-8 | High | `[HIGH]` | `[높음]` |
| 4-6 | Medium | `[MEDIUM]` | `[중간]` |
| 1-3 | Low | `[LOW]` | `[낮음]` |
