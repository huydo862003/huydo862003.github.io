---
_type: PltFlashcard
_label: "How does Yuku's scratch buffer pattern avoid per-block allocation?"
concepts:
  - fref("/01-programming-language-theory/02-concepts/parsing.td")
  - fref("/01-programming-language-theory/02-concepts/arena.td")
tags:
  - 'compiler implementation'
---

::: flashcard{deck="Data-Oriented Parsing"}
How does Yuku's scratch buffer pattern avoid per-block allocation?
=== key
The parser keeps a few scratch stacks for the whole parse. A list records the stack's length (checkpoint) when it begins, pushes items, copies them into the shared `extras` array in one go when it ends, and truncates back. Nesting costs nothing because inner lists flush before outer ones continue.
:::
