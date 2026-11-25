---
_type: PltFlashcard
_label: 'How does flattening an AST naturally lead to bytecode interpretation?'
concepts:
  - fref("/01-programming-language-theory/02-concepts/abstract-syntax-tree-ast.td")
  - fref("/01-programming-language-theory/02-concepts/arena.td")
tags:
  - 'compiler implementation'
---

::: flashcard{deck="Data-Oriented Parsing"}
How does flattening an AST naturally lead to bytecode interpretation?
=== key
In the extra-flat interpreter, `Expr` structs in the array act as bytecode instructions, and `u32` indices act as variable references. Swap the state table for a stack and it becomes indistinguishable from a bytecode interpreter designed from first principles. The data structure change alone bridges tree-walking and bytecode.
:::
