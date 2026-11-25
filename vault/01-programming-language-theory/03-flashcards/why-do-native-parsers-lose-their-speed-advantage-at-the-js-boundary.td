---
_type: PltFlashcard
_label: 'Why do native parsers lose their speed advantage at the JS boundary?'
concepts:
  - fref("/01-programming-language-theory/02-concepts/parsing.td")
  - fref("/01-programming-language-theory/02-concepts/abstract-syntax-tree-ast.td")
tags:
  - 'compiler implementation'
---

::: flashcard{deck="Data-Oriented Parsing"}
Why do native parsers lose their speed advantage at the JS boundary, and how can this be avoided?
=== key
Most JS tools need the AST as JS objects. The usual approaches (serializing to JSON + `JSON.parse`, or building objects one at a time through N-API) often cost more than the parse itself.

The fix is to make the tree **position-independent**: replace pointers with indices, lists with offset ranges, strings with source offsets. The tree becomes plain bytes that can be memcpy'd into an `ArrayBuffer`. The JS side reads typed arrays directly instead of parsing. This is what lets a native toolchain be fast *and* extensible from JS.
:::
