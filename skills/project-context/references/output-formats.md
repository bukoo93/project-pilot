# Output Format Standards

Consistent formatting across all Project Pilot commands.

## Language Handling

All commands accept `--lang ko` in arguments. When detected:
- Section headers and prose in Korean
- Technical terms (file paths, code identifiers, git refs, package names) remain in English
- Risk badges use Korean labels

## Section Header Format

### English (default)
```
## 📊 Project Analysis Report
Generated: 2026-04-14 | Scope: full project

---
```

### Korean (--lang ko)
```
## 📊 프로젝트 분석 리포트
생성일: 2026-04-14 | 범위: 전체 프로젝트

---
```

## Risk Badge Format

| English | Korean |
|---------|--------|
| `[CRITICAL]` | `[심각]` |
| `[HIGH]` | `[높음]` |
| `[MEDIUM]` | `[중간]` |
| `[LOW]` | `[낮음]` |

## Table Format

Always use markdown tables with alignment:

```markdown
| Item | Score | Location | Description |
|:-----|:-----:|:---------|:------------|
| ... | 8/10 | src/auth.ts:45 | ... |
```

## Summary Box Format

```
> **Summary**: 3 critical issues, 7 high, 12 medium, 23 low
> **Overall Health Score**: 62/100
> **Recommended Priority**: Address critical items in `src/auth/` first
```

## Common Section Translations

| English | Korean |
|---------|--------|
| Summary | 요약 |
| Tech Stack | 기술 스택 |
| Architecture | 아키텍처 |
| Directory Structure | 디렉토리 구조 |
| Business Logic | 비즈니스 로직 |
| Recommendations | 권장 사항 |
| Risk Assessment | 리스크 평가 |
| Dependencies | 의존성 |
| Contributors | 기여자 |
| Hotspots | 핫스팟 |
| Breaking Changes | 호환성 파괴 변경 |
| Release Notes | 릴리즈 노트 |
| New Features | 신규 기능 |
| Bug Fixes | 버그 수정 |
| Refactoring | 리팩토링 |
| Technical Debt | 기술 부채 |
| Impact Analysis | 영향도 분석 |
| Bus Factor | 버스 팩터 |
| Sprint Health | 스프린트 건강도 |
| Onboarding Guide | 온보딩 가이드 |
| Action Items | 조치 항목 |
| Velocity | 속도 |
| Coverage | 커버리지 |
| Complexity | 복잡도 |