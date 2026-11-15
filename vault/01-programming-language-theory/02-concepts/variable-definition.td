---
_type: PltConcept
_label: 'Variable definition'
journey: fref("/01-programming-language-theory/index.td")
status: 'mastered'
books: vault.from_node(self).follow_back(PltBook, "concepts").to_list()
tags:
  - 'language feature/design'
  - 'syntax & grammar'
flashcards: vault.from_node(self).follow_back(PltFlashcard, "concepts").to_list()
---

A syntactic construct that introduces a new variable name and establishes a binding - optionally with an initial value (e.g., let x = 5).

A syntactic construct that introduces a new variable name and establishes a binding - optionally with an initial value (e.g., `let x = 5`).
