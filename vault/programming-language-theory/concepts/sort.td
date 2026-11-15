---
_type: PltConcept
_label: 'Sort'
phase: fref("/programming-language-theory/phases/phase-01-foundations-of-program-specification-and-semantics.td")
journey: fref("/programming-language-theory/index.td")
status: 'learning'
books: vault.from_node(self).follow_back(PltBook, "concepts").to_list()
tags:
  - 'syntax & grammar'
flashcards: vault.from_node(self).follow_back(PltFlashcard, "concepts").to_list()
---

A Syntactic category that classifies [Abstract syntax tree (AST)](/plt/concepts/abstract-syntax-tree-ast)s. Roughly a type for ASTs.
