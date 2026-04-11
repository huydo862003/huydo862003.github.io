---
createdAt: "2026-03-28"
updatedAt: "2026-03-28"
title: "Dependent type"
description: "Consider the $\\text{head}$ function which returns the first item of a list."
journey: plt
status: learning
books: []
dependsOn: []
blocks: []
tags:
  - "logic"
  - "type-theory"
  - "text"
  - "dependent"
  - "types"
  - "list"
  - "head"
  - "function"
  - "type"
  - "length"
  - "becomes"
  - "signature"
---

- Elaboration
    - Simple types can say "this is a list" but not "this is a list of length 5".
    - Dependent types extend Curry-Howard correspondence to predicate logic:
        - $\forall$ becomes $\Pi$ (dependent function).
        - $\exists$ becomes $\Sigma$ (dependent pair).
    - Types can mention values, so preconditions become part of the signature, enforced by the compiler.
- Example
    
    Consider the $\text{head}$ function which returns the first item of a list.
    
    $$
    \text{head} : \text{List}\,a \to a
    $$
    
    Based on the signature, this must either:
    
    - Crash on empty lists.
    - Return $\text{Maybe}\,a$.
    - Lie.
    
    \to With dependent types, the precondition is the caller's proof obligation-no runtime check, no partiality.
    
    \to A safe head function on vectors:
    
    $$
    \text{head} : \text{Vec}\,(n+1)\,a \to a
    $$
    
    \to The type guarantees length $\geq 1$.
