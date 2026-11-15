---
_type: PltConcept
_label: 'Macro'
phase: fref("/programming-language-theory/phases/phase-01-foundations-of-program-specification-and-semantics.td")
journey: fref("/programming-language-theory/index.td")
status: 'mastered'
books: vault.from_node(self).follow_back(PltBook, "concepts").to_list()
tags:
  - 'language feature/design'
  - 'metaprogramming/self-reflection'
  - 'programming paradigm'
  - 'syntax & grammar'
flashcards: vault.from_node(self).follow_back(PltFlashcard, "concepts").to_list()
---

A syntactic pattern that is expanded into other code at compile time via ${fref("/programming-language-theory/concepts/macro-expansion.td")}, enabling metaprogramming by allowing code to generate or transform other code before execution.
