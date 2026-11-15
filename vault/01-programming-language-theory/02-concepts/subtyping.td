---
_type: PltConcept
_label: 'Subtyping'
journey: fref("/01-programming-language-theory/index.td")
status: 'mastered'
books: vault.from_node(self).follow_back(PltBook, "concepts").to_list()
tags:
  - 'language feature/design'
  - 'programming paradigm'
  - 'semantics'
  - 'type theory'
flashcards: vault.from_node(self).follow_back(PltFlashcard, "concepts").to_list()
---

The ${fref("/01-programming-language-theory/02-concepts/type-system.td")} mechanism that defines and enforces when substitution is allowed between types.

The ${fref("/01-programming-language-theory/02-concepts/type-system.td")} mechanism that defines and enforces **when substitution is allowed** between types.
