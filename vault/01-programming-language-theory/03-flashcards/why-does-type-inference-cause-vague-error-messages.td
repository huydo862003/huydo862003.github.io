---
_type: PltFlashcard
_label: 'Why does type inference cause vague error messages?'
concepts:
  - fref("/01-programming-language-theory/02-concepts/type-inference.td")
books:
  - fref("/01-programming-language-theory/01-books/04-programming-languages-application-and-interpretation/05-chapter-5-types.td")
tags:
  - 'compiler implementation'
---

::: flashcard{deck="Compiler Implementation"}
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
