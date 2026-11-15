---
_type: PltConcept
_label: 'Term'
phase: fref("/programming-language-theory/phases/phase-01-foundations-of-program-specification-and-semantics.td")
journey: fref("/programming-language-theory/index.td")
status: 'mastered'
books: vault.from_node(self).follow_back(PltBook, "concepts").to_list()
tags:
  - 'lambda calculus'
  - 'linguistics'
  - 'syntax & grammar'
flashcards: vault.from_node(self).follow_back(PltFlashcard, "concepts").to_list()
---

A term is a syntactic phrase in a grammar that represents computation and evaluates to a value - unlike ${fref("/programming-language-theory/concepts/expression.td")} which broadly encompasses any well-formed syntactic construct including types, patterns, and declarations.
