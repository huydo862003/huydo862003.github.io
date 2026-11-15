---
_type: PltConcept
_label: 'Gallina'
journey: fref("/programming-language-theory/index.td")
status: 'reviewing'
books: vault.from_node(self).follow_back(PltBook, "concepts").to_list()
tags:
  - 'formal system'
  - 'language feature/design'
  - 'proof/reason technique'
flashcards: vault.from_node(self).follow_back(PltFlashcard, "concepts").to_list()
---

A ${fref("/programming-language-theory/concepts/functional-programming.td")} language (${fref("/programming-language-theory/concepts/rocq.td")}'s specification language) that allows writing purely functional programs and formal proofs, using ${fref("/programming-language-theory/concepts/dependent-type.td")} to express precise logical properties.
