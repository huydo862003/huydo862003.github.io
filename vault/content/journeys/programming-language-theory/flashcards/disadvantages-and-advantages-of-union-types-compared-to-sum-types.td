---
_type: Flashcard
deck: 'type-theory'
books:
  - fref("journeys/programming-language-theory/books/programming-languages-application-and-interpretation/chapter-5-types.td")
---

::: flashcard
Disadvantages and advantages of union types compared to sum types?
=== key
Depending on the exact language, tooling and runtime:

- If the compiler does not provide flow typing, then working with union types can either be unsafe or frustrating.
- In languages like C, sum types would take more space than union types. However, in other languages, for union types to be safe, runtime tags are needed and can take more space than sum types.
- Sum types have a canonical way to match type variants, while union types may depend on the language.
- Union types can contain duplicate variants, while sum types cannot.
- Harder to infer types for union types.
:::
