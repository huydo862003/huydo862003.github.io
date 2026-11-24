---
_type: PltFlashcard
_label: "How to utilize the property of word-aligned addresses to optimize number's place"
books:
  - fref("/01-programming-language-theory/01-books/04-programming-languages-application-and-interpretation/05-chapter-5-types.td")
tags:
  - 'compiler implementation'
---

::: flashcard{deck="Compiler Implementation"}
How to utilize the property of word-aligned addresses to optimize number's placements?
=== key
- In languages that mostly allocate memory for objects on the heap.
- These memory should in most case be word-aligned.

    -> The pointers would contain `00` at the end.

    -> Use this as a tag to differentiate numbers.
:::
