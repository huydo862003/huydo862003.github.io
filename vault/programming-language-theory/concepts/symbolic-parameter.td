---
_type: PltConcept
_label: 'Symbolic parameter'
journey: fref("/programming-language-theory/index.td")
status: 'reviewing'
books: vault.from_node(self).follow_back(PltBook, "concepts").to_list()
tags:
  - 'syntax & grammar'
flashcards: vault.from_node(self).follow_back(PltFlashcard, "concepts").to_list()
---

Analogous to ${fref("/programming-language-theory/concepts/symbol.td")}.
