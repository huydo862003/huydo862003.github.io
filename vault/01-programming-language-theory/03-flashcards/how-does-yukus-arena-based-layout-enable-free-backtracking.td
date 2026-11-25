---
_type: PltFlashcard
_label: "How does Yuku's arena-based layout enable free backtracking?"
concepts:
  - fref("/01-programming-language-theory/02-concepts/parsing.td")
  - fref("/01-programming-language-theory/02-concepts/arena.td")
tags:
  - 'compiler implementation'
---

::: flashcard{deck="Data-Oriented Parsing"}
How does Yuku's arena-based layout enable free backtracking?
=== key
A checkpoint is the lexer position plus the current lengths of the node, extras, and diagnostics arrays. Rewinding just truncates them back. Whatever a failed attempt built is just the tail of those arrays, so there is nothing to free.
:::
