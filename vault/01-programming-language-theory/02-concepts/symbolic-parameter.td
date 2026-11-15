---
_type: PltConcept
_label: 'Symbolic parameter'
journey: fref("/01-programming-language-theory/index.td")
status: 'mastered'
books: vault.from_node(self).follow_back(PltBook, "concepts").to_list()
tags:
  - 'syntax & grammar'
flashcards: vault.from_node(self).follow_back(PltFlashcard, "concepts").to_list()
---

Analogous to ${fref("/01-programming-language-theory/02-concepts/symbol.td")}.
