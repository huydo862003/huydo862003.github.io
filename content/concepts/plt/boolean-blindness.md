---
createdAt: "2026-03-28"
updatedAt: "2026-03-28"
title: "Boolean blindness"
description: "→ The boolean discards it; you must later \"remember\" what it meant."
journey: plt
status: learning
books: []
dependsOn: []
blocks: []
tags:
  - "design-principle"
  - "type-theory"
  - "boolean"
  - "bit"
  - "must"
  - "constructive"
  - "witness"
  - "iszero"
  - "information"
  - "approach"
  - "pred"
  - "blindness"
---

- Elaboration
    - Constructive types preserve the witness; booleans erase it.
    - When you compute `isZero n`, you learn one bit.
    - But you had richer information-the structure of `n`.
    
    → The boolean discards it; you must later "remember" what it meant.
    
    → As Robert Harper puts it: to use a boolean you must know its provenance, but you've blinded yourself by reducing information to a bit.
    
- Example
    - Boolean approach (blind)
        
        ```
        f = if isZero n then y else f (pred n)
        ```
        
        → Information is collapsed to a bit, branched, then had to recover what you lost - `pred` must re-check that `n` is non-zero.
        
    - Constructive approach (witnessing)
        
        ```
        f = case n of
          Zero   → y
          Succ m → f m
        ```
        
        The pattern match *is* the proof of non-zero-ness. The witness `m` is the predecessor-extracted, not recomputed.
