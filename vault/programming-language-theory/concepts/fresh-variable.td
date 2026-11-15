---
_type: PltConcept
_label: 'Fresh variable'
journey: fref("/programming-language-theory/index.td")
status: 'mastered'
books: vault.from_node(self).follow_back(PltBook, "concepts").to_list()
tags:
  - 'semantics'
  - 'syntax & grammar'
flashcards: vault.from_node(self).follow_back(PltFlashcard, "concepts").to_list()
---

Given a set of variable $\mathcal{X}$, a Variable $v \notin \mathcal{X}$.
