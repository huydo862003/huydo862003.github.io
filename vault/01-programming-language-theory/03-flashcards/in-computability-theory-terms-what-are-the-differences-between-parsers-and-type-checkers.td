---
_type: PltFlashcard
_label: 'In computability theory terms, what are the differences between parsers and type checkers?'
books:
  - fref("/01-programming-language-theory/01-books/04-programming-languages-application-and-interpretation/05-chapter-5-types.td")
tags:
  - 'language theory'
---

::: flashcard{deck="Language Theory"}
In computability theory terms, what are the differences between parsers and type checkers?
=== key
| Phase | Constraint type | Complexity | Example checks |
| --- | --- | --- | --- |
| **Parsing** | **Context-free** | Less complex (CFG) | Balanced parentheses, syntax structure |
| **Type-checking** | **Context-sensitive** | More complex (CSG) | Variable declared before use, type compatibility |
:::
