---
published: true
author: Hdnax
createdAt: "2026-03-28"
updatedAt: "2026-03-28"
question: What are the ideas of micro and macro gradual typings?
deck: type-theory
concepts:
  - gradual-typing
  - macro-gradual-typing
  - micro-gradual-typing
books:
  - chapter-5-types
tags: []
---

Gradual typing is often the formal term for retrofitted type systems.

- Micro gradual typing: The typed and untyped languages coexist within the same program, requiring a type to represent "untyped values".
- Macro gradual typing: The typed and untyped languages live separately but communicate via a contract. Contract violation and blame tracking are usually provided.
