---
_type: PltFlashcard
_label: 'Why does Yuku represent strings as offsets into the source?'
concepts:
  - fref("/01-programming-language-theory/02-concepts/parsing.td")
tags:
  - 'compiler implementation'
---

::: flashcard{deck="Data-Oriented Parsing"}
Why does Yuku represent strings as offsets into the source?
=== key
Almost every string a parser produces already exists in the source byte for byte. A string is a start/end offset: below the source length it slices the source directly, past it reads from a tiny pool for decoded strings (e.g., escape sequences). The lexer never decodes while scanning, it just sets a flag. For an 8 MB file the pool stays tiny, and at the JS boundary only the pool crosses, the source text never does.
:::
