---
_type: PltConcept
_label: 'Retrofitted type system'
phase: fref("/01-programming-language-theory/phases/phase-01-foundations-of-program-specification-and-semantics.td")
journey: fref("/01-programming-language-theory/index.td")
status: 'mastered'
books: vault.from_node(self).follow_back(PltBook, "concepts").to_list()
tags:
  - 'language feature/design'
  - 'type theory'
flashcards: vault.from_node(self).follow_back(PltFlashcard, "concepts").to_list()
---

A ${fref("/01-programming-language-theory/02-concepts/type-system.td")} added to an existing untyped language after the fact - must accommodate existing idioms and codebases rather than designing types from scratch.

A type system **added to an existing untyped language** after the fact - must accommodate existing idioms and codebases rather than designing types from scratch.
