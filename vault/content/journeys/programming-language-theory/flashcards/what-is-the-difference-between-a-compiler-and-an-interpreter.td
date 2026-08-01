---
_type: Flashcard
question: "What is the difference between a compiler and an interpreter?"
deck: 'programming-language-basic'
concepts:
  - fref("journeys/programming-language-theory/concepts/compiler.td")
  - fref("journeys/programming-language-theory/concepts/interpreter.td")
books:
  - fref("journeys/programming-language-theory/books/programming-languages-application-and-interpretation/chapter-2-evaluation.td")
---

::: flashcard
${question}
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
