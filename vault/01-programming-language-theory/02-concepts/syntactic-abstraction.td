---
_type: PltConcept
_label: 'Syntactic abstraction'
journey: fref("/01-programming-language-theory/index.td")
status: 'mastered'
books: vault.from_node(self).follow_back(PltBook, "concepts").to_list()
tags:
  - 'language feature/design'
  - 'metaprogramming/self-reflection'
  - 'programming paradigm'
  - 'syntax & grammar'
flashcards: vault.from_node(self).follow_back(PltFlashcard, "concepts").to_list()
---

A mechanism for defining new syntax forms, typically through ${fref("/01-programming-language-theory/02-concepts/macro.td")}s, that expand into existing language constructs. Enables language extension without modifying the core implementation.
