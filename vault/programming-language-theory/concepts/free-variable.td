---
_type: PltConcept
_label: 'Free variable'
journey: fref("/programming-language-theory/index.td")
status: 'mastered'
books: vault.from_node(self).follow_back(PltBook, "concepts").to_list()
tags:
  - 'lambda calculus'
  - 'syntax & grammar'
flashcards: vault.from_node(self).follow_back(PltFlashcard, "concepts").to_list()
---

A variable that is not bound by any enclosing $\lambda$. Contrast with ${fref("/programming-language-theory/concepts/bound-variable.td")}.
