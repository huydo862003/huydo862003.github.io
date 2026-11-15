---
_type: PltConcept
_label: 'Indexed operator'
journey: fref("/programming-language-theory/index.td")
status: 'reviewing'
books: vault.from_node(self).follow_back(PltBook, "concepts").to_list()
tags:
  - 'syntax & grammar'
flashcards: vault.from_node(self).follow_back(PltFlashcard, "concepts").to_list()
---

A family of operators $o$ indexed by symbols $u$, so that $o[u]$ is an operator when $u$ is an available symbol.
