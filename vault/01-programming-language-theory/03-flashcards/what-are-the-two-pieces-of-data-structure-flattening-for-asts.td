---
_type: PltFlashcard
_label: 'What are the two pieces of data structure flattening for ASTs?'
concepts:
  - fref("/01-programming-language-theory/02-concepts/abstract-syntax-tree-ast.td")
  - fref("/01-programming-language-theory/02-concepts/arena-allocator.td")
  - fref("/01-programming-language-theory/02-concepts/arena.td")
tags:
  - 'compiler implementation'
---

::: flashcard{deck="Data-Oriented Parsing"}
What are the two pieces of data structure flattening for ASTs?
=== key
1. Pack all AST nodes into a single, contiguous array (the arena) instead of heap-allocating them individually.
2. Replace pointers with array indices (e.g., `u32`) into that arena.
:::
