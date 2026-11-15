---
_type: PltConcept
_label: 'Macro expansion'
phase: fref("/01-programming-language-theory/phases/phase-01-foundations-of-program-specification-and-semantics.td")
journey: fref("/01-programming-language-theory/index.td")
status: 'mastered'
books: vault.from_node(self).follow_back(PltBook, "concepts").to_list()
tags:
  - 'compiler implementation'
  - 'language feature/design'
  - 'metaprogramming/self-reflection'
  - 'syntax & grammar'
flashcards: vault.from_node(self).follow_back(PltFlashcard, "concepts").to_list()
---

A compile-time code transformation where macro invocations are replaced by their expanded definitions, enabling ${fref("/01-programming-language-theory/02-concepts/syntactic-abstraction.td")} and code generation before regular compilation.
