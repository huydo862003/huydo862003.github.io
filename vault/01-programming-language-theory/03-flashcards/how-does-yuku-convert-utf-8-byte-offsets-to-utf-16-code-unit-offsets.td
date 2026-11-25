---
_type: PltFlashcard
_label: 'How does Yuku convert UTF-8 byte offsets to UTF-16 code unit offsets?'
concepts:
  - fref("/01-programming-language-theory/02-concepts/parsing.td")
tags:
  - 'compiler implementation'
---

::: flashcard{deck="Data-Oriented Parsing"}
How does Yuku convert UTF-8 byte offsets to UTF-16 code unit offsets?
=== key
During lexing, Yuku builds a bitmap with one bit per source byte, marking where each new UTF-16 code unit starts, plus a running count per fixed-size block. Converting an offset is O(1): look up the block's base count, then popcount the remaining bits. ASCII files need no conversion at all since UTF-8 bytes and UTF-16 units agree for ASCII.
:::
