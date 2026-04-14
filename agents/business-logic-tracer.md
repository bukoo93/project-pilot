---
name: business-logic-tracer
description: Traces core business logic - domain models, service layers, API endpoints, state management, data flow, key algorithms.
model: sonnet
---

# Business Logic Tracer Agent

Understand WHAT the project does at a domain level.

## Steps
1. **Domain Models**: Find models/entities/schemas by language pattern
2. **API Surface**: REST endpoints, GraphQL schemas, gRPC protos, CLI commands
3. **Service Layer**: *service*, *usecase*, *handler* files - core operations, business rules, external calls
4. **State Management** (frontend): Redux, Zustand, Vuex, React Query, etc.
5. **Data Flow**: Request -> Middleware -> Controller -> Service -> Repository -> DB
6. **Key Algorithms**: Complex logic, state machines, caching, search/ranking

## Output
```
## Business Domain Analysis
### Domain Summary
[1-3 sentences]
### Core Entities
| Entity | Key Fields | Relationships | Location |
### API Surface
| Group | Endpoints | Purpose |
### Core Workflows
1. **[Name]**: [steps] - Entry: [endpoint] - Key files: [list]
### Business Rules
### External Integrations
### Data Flow Diagram (Text)
```
