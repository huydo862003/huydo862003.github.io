---
_type: PltConcept
_label: 'Simultaneous inductive definition'
phase: fref("/01-programming-language-theory/phases/phase-01-foundations-of-program-specification-and-semantics.td")
journey: fref("/01-programming-language-theory/index.td")
status: 'mastered'
books: vault.from_node(self).follow_back(PltBook, "concepts").to_list()
tags:
  - 'logic'
  - 'proof/reason technique'
  - 'set theory & relation'
flashcards: vault.from_node(self).follow_back(PltFlashcard, "concepts").to_list()
---

A definition technique that define more than one sets at once as a collection of ${fref("/01-programming-language-theory/02-concepts/inference-rule.td")}s to determine membership of the elements of the sets - each inference rule shall refer to the sets in its ${fref("/01-programming-language-theory/02-concepts/premise.td")}s and its ${fref("/01-programming-language-theory/02-concepts/conclusion.td")}s.
