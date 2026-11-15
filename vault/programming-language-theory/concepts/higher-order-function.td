---
_type: PltConcept
_label: 'Higher-order function'
journey: fref("/programming-language-theory/index.td")
status: 'mastered'
books: vault.from_node(self).follow_back(PltBook, "concepts").to_list()
tags:
  - 'language feature/design'
flashcards: vault.from_node(self).follow_back(PltFlashcard, "concepts").to_list()
---

A function that accepts or returns another function.
