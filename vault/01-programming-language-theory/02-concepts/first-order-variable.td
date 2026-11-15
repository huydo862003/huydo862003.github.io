---
_type: PltConcept
_label: 'First-order variable'
phase: fref("/01-programming-language-theory/phases/phase-01-foundations-of-program-specification-and-semantics.td")
journey: fref("/01-programming-language-theory/index.td")
status: 'mastered'
books: vault.from_node(self).follow_back(PltBook, "concepts").to_list()
tags:
  - 'language feature/design'
  - 'semantics'
  - 'syntax & grammar'
flashcards: vault.from_node(self).follow_back(PltFlashcard, "concepts").to_list()
---

A variable that ranges over data values (e.g., integers, booleans, records) - as opposed to ${fref("/01-programming-language-theory/02-concepts/higher-order-function.td")} variables which can hold functions or other computational entities.
