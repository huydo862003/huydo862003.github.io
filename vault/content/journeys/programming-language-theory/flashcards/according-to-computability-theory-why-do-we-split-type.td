---
_type: Flashcard
question: "According to computability theory, why do we split type checkers from parsers?"
deck: 'compiler-implementation'
books:
  - fref("journeys/programming-language-theory/books/programming-languages-application-and-interpretation/chapter-5-types.td")
---

::: flashcard
${question}
=== key
- Parser: Easy context-free grammar handling. Efficient & Decidable algorithms exist.

- Type checker: Context-sensitive. Can be inefficient or decidable.
:::
