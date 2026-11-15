---
_type: PltConcept
_label: 'Tuple'
journey: fref("/01-programming-language-theory/index.td")
status: 'mastered'
books: vault.from_node(self).follow_back(PltBook, "concepts").to_list()
tags:
  - 'data structure & algorithm'
  - 'language feature/design'
flashcards: vault.from_node(self).follow_back(PltFlashcard, "concepts").to_list()
---

A data structure that groups a fixed number of values of possibly different types (like (1, \"hello\", true)), accessed by position rather than name.

A **data structure** that groups a fixed number of values of possibly different types (like `(1, "hello", true)`), accessed by position rather than name.
