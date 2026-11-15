---
_type: PltConcept
_label: 'Lambda calculus'
phase: fref("/programming-language-theory/phases/phase-01-foundations-of-program-specification-and-semantics.td")
journey: fref("/programming-language-theory/index.td")
status: 'learning'
books: vault.from_node(self).follow_back(PltBook, "concepts").to_list()
tags:
  - 'formal system'
  - 'lambda calculus'
  - 'semantics'
  - 'syntax & grammar'
flashcards: vault.from_node(self).follow_back(PltFlashcard, "concepts").to_list()
---

A minimal formal system for expressing computation using only variable binding and function application, yet serves as a foundation that can be extended with types, effects, recursion primitives, and other constructs to form the basis of modern programming languages.
