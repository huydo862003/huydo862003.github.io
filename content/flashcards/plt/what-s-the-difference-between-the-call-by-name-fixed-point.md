---
createdAt: "2026-03-28"
updatedAt: "2026-03-28"
question: What's the difference between the call-by-name fixed-point combinator and the call-by-value fixed-point combinator?
answer: TODO
deck: pure-lambda-calculus
concepts: []
books:
  - chapter-5-the-untyped-pure-lambda-calculus
tags: []
keywords:
  - "lambda"
  - "languages"
  - "call-by-value"
  - "call-by-name"
  - "fixed-point"
  - "combinator"
---

- Call-by-name fixed-point combinator - Curry/Y-Combinator:
    
    $$
    Y = \lambda f.\ (\lambda x.\ f\ x\ x)\ (\lambda x.\ f\ x\ x) 
    $$
    
    \to Used in call-by-name languages because of the lazy evaluation strategy.
    
    \to Not used in call-by-value languages because it always diverges when applied to a function
    
- Call-by-value fixed-point combinator - Z-combinator:
    
    $$
    Z = \lambda f.\ (\lambda x.\ f\ (\lambda v.\ x\ x\ v))\ (\lambda x.\ f\ (\lambda v.\ x\ x\ v))
    $$
    
    → Used in call-by-value languages.
