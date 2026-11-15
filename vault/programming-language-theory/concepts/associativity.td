---
_type: PltConcept
_label: 'Associativity'
journey: fref("/programming-language-theory/index.td")
status: 'mastered'
books: vault.from_node(self).follow_back(PltBook, "concepts").to_list()
tags:
  - 'syntax & grammar'
flashcards: vault.from_node(self).follow_back(PltFlashcard, "concepts").to_list()
---

A parsing rule that determines grouping when the same operator repeats (left: a - b - c = (a - b) - c; right: a :: b :: c = a :: (b :: c)).

A **parsing rule** that determines grouping when the same operator repeats (left: `a - b - c` = `(a - b) - c`; right: `a :: b :: c` = `a :: (b :: c)`).
