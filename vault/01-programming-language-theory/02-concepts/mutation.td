---
_type: PltConcept
_label: 'Mutation'
journey: fref("/01-programming-language-theory/index.td")
status: 'mastered'
books: vault.from_node(self).follow_back(PltBook, "concepts").to_list()
tags:
  - 'language feature/design'
  - 'semantics'
flashcards: vault.from_node(self).follow_back(PltFlashcard, "concepts").to_list()
---

The act of modifying a value in place at a memory location, rather than producing a new value - introducing ${fref("/01-programming-language-theory/02-concepts/state.td")} changes that depend on evaluation order and complicating equational reasoning.
