---
_type: PltFlashcard
_label: 'SICP: Benefits of introducing assignment and local state'
deck: 'language theory'
concepts:
  - fref("/01-programming-language-theory/02-concepts/state.td")
  - fref("/01-programming-language-theory/02-concepts/mutation.td")
books:
  - fref("/01-programming-language-theory/01-books/05-structure-and-interpretation-of-computer-programs/03-chapter-3-modularity-objects-and-state.td")
tags:
  - 'semantics'
---

::: flashcard
What is the benefit of introducing assignment and local state variables? What is the cost?
=== key
**Benefit**: By introducing assignment (`set!`) and hiding state in local variables, we are able to structure systems in a *more modular* fashion.

Example: A `rand` procedure with a local `x` state variable hides the random seed - callers don't need to manage it. Without assignment, the internal state leaks out and callers must supply and thread it through explicitly, reducing modularity.

**Cost**: The substitution model of computation no longer adequately models procedure application. We need the more complex *environment model* of computation. Assignment introduces time into our programs: the same expression may return different values at different points in time, breaking the ability to reason equationally (equals can no longer always be substituted for equals).
:::
