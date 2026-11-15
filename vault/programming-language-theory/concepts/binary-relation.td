---
_type: PltConcept
_label: 'Binary relation'
journey: fref("/programming-language-theory/index.td")
status: 'mastered'
books: vault.from_node(self).follow_back(PltBook, "concepts").to_list()
tags:
  - 'set theory & relation'
flashcards: vault.from_node(self).follow_back(PltFlashcard, "concepts").to_list()
---

An ${fref("/programming-language-theory/concepts/n-place-relation.td")} where $n = 2$.
