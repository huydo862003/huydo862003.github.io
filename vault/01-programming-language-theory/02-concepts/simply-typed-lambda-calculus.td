---
_type: PltConcept
_label: 'Simply typed lambda calculus'
journey: fref("/01-programming-language-theory/index.td")
status: 'learning'
books: vault.from_node(self).follow_back(PltBook, "concepts").to_list()
tags:
  - 'lambda calculus'
  - 'semantics'
  - 'syntax & grammar'
  - 'type theory'
flashcards: vault.from_node(self).follow_back(PltFlashcard, "concepts").to_list()
---

The foundational typed lambda calculus where each ${fref("/01-programming-language-theory/02-concepts/lambda-abstraction.td")} explicitly annotates its parameter with a type, providing a basis for more advanced type systems while guaranteeing termination.
