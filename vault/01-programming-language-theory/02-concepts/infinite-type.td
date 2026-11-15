---
_type: PltConcept
_label: 'Infinite type'
journey: fref("/01-programming-language-theory/index.td")
status: 'mastered'
books: vault.from_node(self).follow_back(PltBook, "concepts").to_list()
tags:
  - 'language feature/design'
  - 'type theory'
flashcards: vault.from_node(self).follow_back(PltFlashcard, "concepts").to_list()
---

A type that has infinitely many inhabitants (like nat, string, or list), as opposed to finite types like bool or enums with fixed members.

A **type** that has infinitely many inhabitants (like `nat`, `string`, or `list`), as opposed to ${fref("/01-programming-language-theory/02-concepts/finite-type.td")}s like `bool` or enums with fixed members.
