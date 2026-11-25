---
_type: PltFlashcard
_label: "What makes Yuku's AST position-independent and why does that matter for JS?"
concepts:
  - fref("/01-programming-language-theory/02-concepts/abstract-syntax-tree-ast.td")
  - fref("/01-programming-language-theory/02-concepts/parsing.td")
tags:
  - 'compiler implementation'
---

::: flashcard{deck="Data-Oriented Parsing"}
What makes Yuku's AST position-independent and why does that matter for JS?
=== key
Children are indices, lists are offsets into extras, strings are offsets into the source. No pointers anywhere. The tree is already position-independent bytes, so serializing to JS is mostly a memcpy into an `ArrayBuffer`. The JS decoder reads from a typed array with no parsing step, and each node kind gets a fixed key order so V8 assigns the same hidden class. This is 3-9x faster than Acorn, Babel, Oxc, and SWC at delivering ASTs to JS.
:::
