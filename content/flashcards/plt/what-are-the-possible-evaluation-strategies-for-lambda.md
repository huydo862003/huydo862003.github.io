---
createdAt: "2026-03-28"
updatedAt: "2026-03-28"
question: What are the possible evaluation strategies for lambda calculus?
answer: TODO
deck: pure-lambda-calculus
concepts: []
books:
  - chapter-5-the-untyped-pure-lambda-calculus
tags:
  - "reduced"
  - "call"
  - "redexes"
  - "normal"
  - "order"
  - "redex"
---

- Full beta-reduction.
    
    Any redexes can be reduced.
    
- Normal order.
    
    Only the left-most outermost redex can be reduced.
    
- Call by name.
    
    Normal order but nested redex inside labda abstractions cannot be reduced.
    
- Call by need.
    
    Call by name but with caching to avoid recomputation.
    
- Call by value.
    
    Redexes can only be reduced if their argument is a value.
