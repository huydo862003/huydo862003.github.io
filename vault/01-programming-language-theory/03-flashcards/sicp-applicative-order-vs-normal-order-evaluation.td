---
_type: PltFlashcard
_label: 'SICP: Applicative order vs normal order evaluation'
concepts:
  - fref("/01-programming-language-theory/02-concepts/call-by-value.td")
  - fref("/01-programming-language-theory/02-concepts/call-by-name.td")
  - fref("/01-programming-language-theory/02-concepts/evaluation-strategy.td")
books:
  - fref("/01-programming-language-theory/01-books/05-structure-and-interpretation-of-computer-programs/01-chapter-1-building-abstractions-with-procedures/index.td")
tags:
  - 'semantics'
---

::: flashcard{deck="08-Language Theory"}
What is the difference between applicative-order and normal-order evaluation? Which does Scheme use and why?
=== key
- *Normal-order*: "Fully expand and then reduce" - arguments are substituted unevaluated into the procedure body first, then reduced.
- *Applicative-order* (call-by-value): Evaluate the arguments first, then apply. This is what Scheme uses.

Scheme uses applicative-order because:
1. Additional efficiency (avoids evaluating the same expression multiple times).
2. Normal-order becomes unwieldy outside the realm of procedures that can be modeled by substitution.

For procedures modeled by substitution that yield legitimate values, both strategies produce the same result.
:::
