---
_type: PltFlashcard
_label: 'Why are pointer-based ASTs bad for CPU cache and cross-process sharing?'
concepts:
  - fref("/01-programming-language-theory/02-concepts/abstract-syntax-tree-ast.td")
  - fref("/01-programming-language-theory/02-concepts/parsing.td")
tags:
  - 'compiler implementation'
---

::: flashcard{deck="Data-Oriented Parsing"}
Why are pointer-based ASTs bad for CPU cache and cross-process sharing?
=== key
- Each node is its own heap allocation, so every tree walk is a chain of dependent loads the CPU can't predict (cache misses).
- The tree is full of absolute addresses, so it only means something inside the process that built it. Can't write to disk or hand to another runtime without rebuilding object by object.
:::
