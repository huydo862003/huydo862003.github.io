---
_type: PltConcept
_label: 'Structural/Abstract syntax'
journey: fref("/programming-language-theory/index.td")
status: 'reviewing'
books: vault.from_node(self).follow_back(PltBook, "concepts").to_list()
tags:
  - 'compiler implementation'
  - 'syntax & grammar'
flashcards: vault.from_node(self).follow_back(PltFlashcard, "concepts").to_list()
---

::: info
(Syntax & Grammar) According to Practical foundations for programming languages, the program's tree structure ([Abstract syntax tree (AST)](/plt/concepts/abstract-syntax-tree-ast)) showing how phrases are built from ${fref("/programming-language-theory/concepts/operator.td")}s and subphrases.
:::
