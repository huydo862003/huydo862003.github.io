---
_type: PltConcept
_label: 'Type constructor'
journey: fref("/01-programming-language-theory/index.td")
status: 'mastered'
books: vault.from_node(self).follow_back(PltBook, "concepts").to_list()
tags:
  - 'language feature/design'
  - 'type theory'
flashcards: vault.from_node(self).follow_back(PltFlashcard, "concepts").to_list()
---

A function at the type level that builds new types from existing ones, such as List, Array, or the arrow constructor ($\\to$) that constructs function types.

A function at the type level that builds new types from existing ones, such as `List`, `Array`, or the arrow constructor ($\to$) that constructs function types.
