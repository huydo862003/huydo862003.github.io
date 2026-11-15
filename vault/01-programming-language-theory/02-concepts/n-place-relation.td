---
_type: PltConcept
_label: 'N-place relation'
journey: fref("/01-programming-language-theory/index.td")
status: 'mastered'
books: vault.from_node(self).follow_back(PltBook, "concepts").to_list()
tags:
  - 'set theory & relation'
flashcards: vault.from_node(self).follow_back(PltFlashcard, "concepts").to_list()
---

Given $n$ sets $X_1, X_2, ..., X_n$, the subset of the Cartesian product $X_1 \times X_2 \times ... \times X_n$.
