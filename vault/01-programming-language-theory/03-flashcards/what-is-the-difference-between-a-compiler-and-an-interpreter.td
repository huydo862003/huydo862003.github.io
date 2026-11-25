---
_type: PltFlashcard
_label: 'What is the difference between a compiler and an interpreter?'
concepts:
  - fref("/01-programming-language-theory/02-concepts/compiler.td")
  - fref("/01-programming-language-theory/02-concepts/interpreter.td")
books:
  - fref("/01-programming-language-theory/01-books/04-programming-languages-application-and-interpretation/02-chapter-2-evaluation.td")
tags:
  - 'programming language basic'
---

::: flashcard{deck="01-Programming Language Basics"}
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
