---
_type: Flashcard
deck: 'compiler-implementation'
books:
  - fref("programming-language-theory/books/programming-languages-application-and-interpretation/chapter-5-types.td")
---

::: flashcard
How to utilize the property of word-aligned addresses to optimize number's placements?
=== key
- In languages that mostly allocate memory for objects on the heap.
- These memory should in most case be word-aligned.

    -> The pointers would contain `00` at the end.

    -> Use this as a tag to differentiate numbers.
:::
