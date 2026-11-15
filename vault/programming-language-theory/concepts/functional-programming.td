---
_type: PltConcept
_label: 'Functional programming'
phase: fref("/programming-language-theory/phases/phase-01-foundations-of-program-specification-and-semantics.td")
journey: fref("/programming-language-theory/index.td")
status: 'mastered'
books: vault.from_node(self).follow_back(PltBook, "concepts").to_list()
tags:
  - 'programming paradigm'
flashcards: vault.from_node(self).follow_back(PltFlashcard, "concepts").to_list()
---

A programming paradigm centered on pure functions, immutability, and expressions rather than statements, treating computation as evaluation of mathematical functions.

A **programming paradigm** centered on pure functions, immutability, and ${fref("/programming-language-theory/concepts/expression.td")}s rather than ${fref("/programming-language-theory/concepts/statement.td")}s, treating computation as evaluation of mathematical functions.
