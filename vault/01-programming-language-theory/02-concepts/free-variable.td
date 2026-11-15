---
_type: PltConcept
_label: 'Free variable'
journey: fref("/01-programming-language-theory/index.td")
status: 'mastered'
books: vault.from_node(self).follow_back(PltBook, "concepts").to_list()
tags:
  - 'lambda calculus'
  - 'syntax & grammar'
flashcards: vault.from_node(self).follow_back(PltFlashcard, "concepts").to_list()
---

A variable that is not bound by any enclosing $\lambda$. Contrast with ${fref("/01-programming-language-theory/02-concepts/bound-variable.td")}.
