---
_type: PltConcept
_label: 'Structural recursion'
journey: fref("/01-programming-language-theory/index.td")
status: 'reviewing'
books: vault.from_node(self).follow_back(PltBook, "concepts").to_list()
tags:
  - 'data structure & algorithm'
  - 'language feature/design'
  - 'programming paradigm'
flashcards: vault.from_node(self).follow_back(PltFlashcard, "concepts").to_list()
---

A recursion scheme that decomposes data along its ${fref("/01-programming-language-theory/02-concepts/constructor.td")}s, guaranteeing termination by recursing only on structurally smaller subterms.

A **recursion scheme** that decomposes data along its constructors, guaranteeing termination by recursing only on structurally smaller subterms.
