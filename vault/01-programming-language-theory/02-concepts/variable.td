---
_type: PltConcept
_label: 'Variable'
phase: fref("/01-programming-language-theory/phases/phase-01-foundations-of-program-specification-and-semantics.td")
journey: fref("/01-programming-language-theory/index.td")
status: 'mastered'
books: vault.from_node(self).follow_back(PltBook, "concepts").to_list()
tags:
  - 'syntax & grammar'
flashcards: vault.from_node(self).follow_back(PltFlashcard, "concepts").to_list()
---

::: info
(Syntax & Grammar) According to Practical foundations for programming languages , specifically Chapter 1. Abstract syntax, a syntactic variable which is a placeholder for an [Abstract syntax tree (AST)](/plt/concepts/abstract-syntax-tree-ast) of a specific Sort.
:::
