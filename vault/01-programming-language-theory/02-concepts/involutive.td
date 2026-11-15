---
_type: PltConcept
_label: 'Involutive'
journey: fref("/01-programming-language-theory/index.td")
status: 'mastered'
books: vault.from_node(self).follow_back(PltBook, "concepts").to_list()
tags:
  - 'set theory & relation'
flashcards: vault.from_node(self).follow_back(PltFlashcard, "concepts").to_list()
---

A property of a function where applying it twice returns the original value (i.e., f(f(x)) = x).

A **property** of a function where applying it twice returns the original value (i.e., `f(f(x)) = x`).
