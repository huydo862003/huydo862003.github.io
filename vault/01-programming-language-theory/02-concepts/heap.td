---
_type: PltConcept
_label: 'Heap'
journey: fref("/01-programming-language-theory/index.td")
status: 'mastered'
books: vault.from_node(self).follow_back(PltBook, "concepts").to_list()
tags:
  - 'runtime'
tags:
  - 'runtime'
flashcards: vault.from_node(self).follow_back(PltFlashcard, "concepts").to_list()
---

A region of a process's memory used for dynamic allocation at runtime, growing as needed and managed explicitly (via malloc/free) or by a ${fref("/01-programming-language-theory/02-concepts/garbage-collection.td")} - as opposed to the stack which handles fixed-size, short-lived local variables and call frames.
