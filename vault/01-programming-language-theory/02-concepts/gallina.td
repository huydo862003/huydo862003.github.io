---
_type: PltConcept
_label: 'Gallina'
journey: fref("/01-programming-language-theory/index.td")
status: 'mastered'
books: vault.from_node(self).follow_back(PltBook, "concepts").to_list()
tags:
  - 'formal system'
  - 'language feature/design'
  - 'proof/reason technique'
flashcards: vault.from_node(self).follow_back(PltFlashcard, "concepts").to_list()
---

A ${fref("/01-programming-language-theory/02-concepts/functional-programming.td")} language (${fref("/01-programming-language-theory/02-concepts/rocq.td")}'s specification language) that allows writing purely functional programs and formal proofs, using ${fref("/01-programming-language-theory/02-concepts/dependent-type.td")} to express precise logical properties.
