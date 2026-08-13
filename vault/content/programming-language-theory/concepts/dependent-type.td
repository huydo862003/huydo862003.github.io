---
_type: Concept
_label: 'Dependent type'
title: 'Dependent type'
journey: fref("programming-language-theory/index.td")
status: 'learning'
tags:
  - 'logic'
  - 'type-theory'
---

Consider the $\\text{head}$ function which returns the first item of a list.

- Elaboration
  - Simple types can say "this is a list" but not "this is a list of length 5".
  - Dependent types extend ${fref("programming-language-theory/concepts/curry-howard-correspondence.td")} to predicate logic:
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

    -> With dependent types, the precondition is the caller's proof obligation-no runtime check, no partiality.

    -> A safe head function on vectors:

    $$
    \text{head} : \text{Vec}\,(n+1)\,a \to a
    $$

    -> The type guarantees length $\geq 1$.
