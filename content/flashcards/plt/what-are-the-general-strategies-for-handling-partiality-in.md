---
createdAt: "2026-03-28"
updatedAt: "2026-03-28"
question: What are the general strategies for handling partiality in type systems?
answer: TODO
deck: type-theory
concepts: []
books:
  - chapter-5-types
tags: []
keywords:
  - "pros"
  - "cons"
  - "contract"
  - "simple"
  - "type"
  - "truthful"
---

1. Exception
    - Pros: Simple.
    - Cons: Lie about its contract.
2. Option type
    - Pros: Simple & Truthful about contract.
    - Cons: Do not interoperate with legacy systems. Require migration. Caller needs to explicitly handle error case.
3. Refined type
    - Pros: Extremely type-safe and truthful about its contract.
    - Cons: Undecidable.
