---
createdAt: "2026-03-28"
updatedAt: "2026-03-28"
question: Why is union type popular in retrofitted type systems?
answer: TODO
deck: compiler-implementation
concepts:
  - retrofitted-type-system
books:
  - chapter-5-types
tags: []
keywords:
  - "retrofitted type system"
  - "types"
  - "code"
  - "type"
  - "sum"
  - "previously"
  - "untyped"
---


In previously untyped languages, code can return values of multiple types, for example, valid results & errors.

→ This must be typable in the retrofitted type system.

→ Either union types or sum types. However, sum types require modifying the logic of existing code, rather than the more trivial type annotation additions.
