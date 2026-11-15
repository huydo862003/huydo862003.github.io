---
_type: PltConcept
_label: 'Desugarer'
phase: fref("/programming-language-theory/phases/phase-01-foundations-of-program-specification-and-semantics.td")
journey: fref("/programming-language-theory/index.td")
status: 'learning'
books: vault.from_node(self).follow_back(PltBook, "concepts").to_list()
tags:
  - 'compiler implementation'
  - 'language feature/design'
  - 'metaprogramming/self-reflection'
  - 'syntax & grammar'
flashcards: vault.from_node(self).follow_back(PltFlashcard, "concepts").to_list()
---

A ${fref("/programming-language-theory/concepts/compiler.td")} phase or program that transforms ${fref("/programming-language-theory/concepts/syntactic-sugar.td")} into core language constructs, typically running before interpretation or further compilation stages.
