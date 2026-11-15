---
_type: PltConcept
_label: 'Structural induction'
phase: fref("/01-programming-language-theory/phases/phase-01-foundations-of-program-specification-and-semantics.td")
journey: fref("/01-programming-language-theory/index.td")
status: 'mastered'
books: vault.from_node(self).follow_back(PltBook, "concepts").to_list()
tags:
  - 'proof/reason technique'
flashcards: vault.from_node(self).follow_back(PltFlashcard, "concepts").to_list()
---

A proof technique for inductively defined structures, where a property is shown for all elements by proving base cases and proving composite cases assuming the property holds for all immediate sub-structures.
