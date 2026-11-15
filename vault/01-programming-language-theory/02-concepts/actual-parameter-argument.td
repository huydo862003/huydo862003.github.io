---
_type: PltConcept
_label: 'Actual parameter/argument'
journey: fref("/01-programming-language-theory/index.td")
status: 'mastered'
books: vault.from_node(self).follow_back(PltBook, "concepts").to_list()
tags:
  - 'language feature/design'
  - 'semantics'
  - 'syntax & grammar'
flashcards: vault.from_node(self).follow_back(PltFlashcard, "concepts").to_list()
---

::: info
(Syntax & Grammar) According to Practical foundations for programming languages , the child of an Operator in an [Abstract syntax tree (AST)](/plt/concepts/abstract-syntax-tree-ast).
:::
