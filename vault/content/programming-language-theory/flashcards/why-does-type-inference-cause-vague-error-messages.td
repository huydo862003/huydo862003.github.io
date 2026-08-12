---
_type: Flashcard
deck: 'compiler-implementation'
concepts:
  - fref("programming-language-theory/concepts/type-inference.td")
books:
  - fref("programming-language-theory/books/programming-languages-application-and-interpretation/chapter-5-types.td")
---

::: flashcard
Why does type inference cause vague error messages?
=== key
Sometimes, multiple types are inferred for a variable at different locations. The question: Which type and which location to report?

Example:

$$
f\ x = \text{if}\ x\ \text{then}\ x + 1\ \text{else}\ 2
$$

- $x$ can be a boolean, if so, must report error at $x + 1$ in the then branch .
- $x$ can be a number, if so, must report error at $x$ in the condition.
:::
