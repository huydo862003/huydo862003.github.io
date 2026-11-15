---
_type: PltConcept
_label: 'Syntactic sugar'
phase: fref("/programming-language-theory/phases/phase-01-foundations-of-program-specification-and-semantics.td")
journey: fref("/programming-language-theory/index.td")
status: 'learning'
books: vault.from_node(self).follow_back(PltBook, "concepts").to_list()
tags:
  - 'compiler implementation'
  - 'language feature/design'
  - 'syntax & grammar'
flashcards: vault.from_node(self).follow_back(PltFlashcard, "concepts").to_list()
---

A more convenient or readable syntax that is transformed into a ${fref("/programming-language-theory/concepts/core-calculus-language.td")} construct, providing expressiveness without extending the language's fundamental semantics.
