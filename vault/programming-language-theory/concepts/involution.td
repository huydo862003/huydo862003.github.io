---
_type: PltConcept
_label: 'Involution'
journey: fref("/programming-language-theory/index.td")
status: 'reviewing'
books: vault.from_node(self).follow_back(PltBook, "concepts").to_list()
tags:
  - 'set theory & relation'
flashcards: vault.from_node(self).follow_back(PltFlashcard, "concepts").to_list()
---

A function that is its own inverse, satisfying f(f(x)) = x (like negation on booleans or reversing a list twice).

A **function** that is its own inverse, satisfying `f(f(x)) = x` (like negation on booleans or reversing a list twice).
