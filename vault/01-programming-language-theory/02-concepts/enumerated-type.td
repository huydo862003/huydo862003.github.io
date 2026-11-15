---
_type: PltConcept
_label: 'Enumerated type'
phase: fref("/01-programming-language-theory/phases/phase-01-foundations-of-program-specification-and-semantics.td")
journey: fref("/01-programming-language-theory/index.td")
status: 'learning'
books: vault.from_node(self).follow_back(PltBook, "concepts").to_list()
tags:
  - 'language feature/design'
  - 'programming paradigm'
  - 'type theory'
flashcards: vault.from_node(self).follow_back(PltFlashcard, "concepts").to_list()
---

A data type that defines a fixed set of named values (like enum Color { Red, Green, Blue }), enabling type-safe representation of discrete choices.

A **data type** that defines a fixed set of named values (like `enum Color { Red, Green, Blue }`), enabling type-safe representation of discrete choices.
