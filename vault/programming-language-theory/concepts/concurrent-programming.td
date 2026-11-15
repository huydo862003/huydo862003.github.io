---
_type: PltConcept
_label: 'Concurrent programming'
journey: fref("/programming-language-theory/index.td")
status: 'reviewing'
books: vault.from_node(self).follow_back(PltBook, "concepts").to_list()
tags:
  - 'concurrency theory'
  - 'language feature/design'
  - 'programming paradigm'
flashcards: vault.from_node(self).follow_back(PltFlashcard, "concepts").to_list()
---

A programming paradigm where multiple computations execute in overlapping time periods, managing shared resources and coordination through synchronization primitives.

A **programming paradigm** where multiple computations execute in overlapping time periods, managing shared resources and coordination through synchronization primitives.
