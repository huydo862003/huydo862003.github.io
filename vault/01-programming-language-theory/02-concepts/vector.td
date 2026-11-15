---
_type: PltConcept
_label: 'Vector'
journey: fref("/01-programming-language-theory/index.td")
status: 'mastered'
books: vault.from_node(self).follow_back(PltBook, "concepts").to_list()
tags:
  - 'data structure & algorithm'
flashcards: vault.from_node(self).follow_back(PltFlashcard, "concepts").to_list()
---

A contiguous, dynamically-sized array data structure supporting indexed access and operations like append, typically allocated on the ${fref("/01-programming-language-theory/02-concepts/heap.td")}.
