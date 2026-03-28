---
_type: Flashcard
_label: 'What is the difference between a compiler and an interpreter?'
deck: 'programming-language-basic'
concepts:
  - fref("programming-language-theory/concepts/compiler.td")
  - fref("programming-language-theory/concepts/interpreter.td")
books:
  - fref("programming-language-theory/books/programming-languages-application-and-interpretation/chapter-2-evaluation.td")
---

::: flashcard
What is the difference between a compiler and an interpreter?
=== key
- A compiler can be treated as a function that carries a program in the source programming language to another target programming language.

    $$
    \text{Compiler} : \mathcal{P}_S \to \mathcal{P}_T
    $$

- An interpreter can be treated as a function that carries a program into a value.

    $$
    \text{Interpreter} : \mathcal{P} \to V
    $$
:::
