---
_type: PltConcept
_label: 'Pattern matching'
phase: fref("/programming-language-theory/phases/phase-01-foundations-of-program-specification-and-semantics.td")
journey: fref("/programming-language-theory/index.td")
status: 'mastered'
books: vault.from_node(self).follow_back(PltBook, "concepts").to_list()
tags:
  - 'language feature/design'
  - 'syntax & grammar'
flashcards: vault.from_node(self).follow_back(PltFlashcard, "concepts").to_list()
---

A language construct that deconstructs ${fref("/programming-language-theory/concepts/algebraic-data-type.td")} values by variant, binding fields to variables and enabling the type checker to refine types in each branch - safer than raw predicates + accessors.

A language construct that **deconstructs** algebraic datatype values by variant, binding fields to variables and enabling the type checker to **refine types** in each branch - safer than raw predicates + accessors.
