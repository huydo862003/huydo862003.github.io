---
_type: PltConcept
_label: 'Equivalence'
phase: fref("/01-programming-language-theory/phases/phase-01-foundations-of-program-specification-and-semantics.td")
journey: fref("/01-programming-language-theory/index.td")
status: 'mastered'
books: vault.from_node(self).follow_back(PltBook, "concepts").to_list()
tags:
  - 'set theory & relation'
flashcards: vault.from_node(self).follow_back(PltFlashcard, "concepts").to_list()
---

A ${fref("/01-programming-language-theory/02-concepts/reflexive.td")}, ${fref("/01-programming-language-theory/02-concepts/transitive.td")} and ${fref("/01-programming-language-theory/02-concepts/symmetric.td")} relation.
