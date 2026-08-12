---
_type: Flashcard
question: "In computability theory terms, what are the differences between parsers and type checkers?"
deck: 'language-theory'
books:
  - fref("journeys/programming-language-theory/books/programming-languages-application-and-interpretation/chapter-5-types.td")
---

::: flashcard
${question}
=== key
| Phase | Constraint type | Complexity | Example checks |
| --- | --- | --- | --- |
| **Parsing** | **Context-free** | Less complex (CFG) | Balanced parentheses, syntax structure |
| **Type-checking** | **Context-sensitive** | More complex (CSG) | Variable declared before use, type compatibility |
:::
