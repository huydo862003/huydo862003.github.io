---
published: true
author: Hdnax
createdAt: "2026-03-28"
updatedAt: "2026-03-28"
title: Contract
journey: plt
status: learning
books:
  - chapter-5-types
dependsOn: []
blocks: []
tags:
  - language-feature-design
  - runtime
  - semantics
  - type-theory
---

Problem: When typed code is called from untyped code, the type checker can't guarantee arguments will have correct types - untyped code has no static checking.

- Racket example
    
    **Problem:** When typed code is called from untyped code, the type checker can't guarantee arguments will have correct types - untyped code has no static checking.
    
    **Solution:** Typed Racket wraps exported functions with **runtime checks**:
    
    ```racket
    ; Original typed function
    (define (f [s : String]) : Number
      (+ 1 (or (string->number s) 0)))
    ```
    
    When exported, becomes effectively:
    
    ```racket
    ; Contract-wrapped version
    (define (wrapped-f s)
      (if (string? s)                              ; Check input
          (let ([result (+ 1 (or (string->number s) 0))])
            (if (number? result)                   ; Check output
                result
                (error 'contract "not a Number")))
          (error 'contract "not a String")))
    ```
    
    **Key properties:**
    
    | Aspect | Description |
    | --- | --- |
    | **When checked** | At **language boundary** (typed ↔ untyped) |
    | **What's checked** | Arguments match parameter types, return matches return type |
    | **Blame tracking** | Error identifies **which module** violated the contract |
    | **Higher-order** | For $(A \rightarrow B)$, checks happen when function is **called**, not passed |
    
    **Benefit:** Programmers who add type annotations get enforcement even when called from untyped code - errors are **early** and **informative** rather than deep internal failures.
