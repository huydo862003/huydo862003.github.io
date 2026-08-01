---
_type: Flashcard
question: "What's the most popular semantic style today? why?"
deck: 'language-theory'
concepts:
  - fref("journeys/programming-language-theory/concepts/small-step-structural-operational-semantics-sos.td")
  - fref("journeys/programming-language-theory/concepts/operational-semantics.td")
  - fref("journeys/programming-language-theory/concepts/denotational-semantics.td")
  - fref("journeys/programming-language-theory/concepts/axiomatic-semantics.td")
books:
  - fref("journeys/programming-language-theory/books/types-and-programming-languages/chapter-3-untyped-arithmetic-expressions.td")
---

::: flashcard
${question}
=== key
Of the three:

- Operational semantics.
- Denotational semantics.
- Axiomatic semantics.

Operational semantics is the most popular.

Originally, operational semantics was deemed inelegant, mathematically weak and often used for quick-and-dirty purposes only.

However, now it's popular because it's flexible and can address many aspects of programming languages that cannot be comfortably addressed by denotational semantics (concurrency) and axiomatic semantics (procedure).
:::
