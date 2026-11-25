---
_type: PltFlashcard
_label: 'Why does Yuku store AST nodes as struct of arrays instead of array of structs?'
concepts:
  - fref("/01-programming-language-theory/02-concepts/abstract-syntax-tree-ast.td")
  - fref("/01-programming-language-theory/02-concepts/parsing.td")
tags:
  - 'compiler implementation'
---

::: flashcard{deck="Data-Oriented Parsing"}
Why does Yuku store AST nodes as struct of arrays instead of array of structs?
=== key
Using `MultiArrayList` (columnar storage), each field is stored in its own dense array. A pass that only switches on node kinds reads one column and never pulls spans or data through the cache. This avoids cache pollution when only a subset of fields is needed.
:::
