---
_type: PltFlashcard
_label: 'The relation between an evaluator and an interpreter?'
deck: 'programming language basic'
concepts:
  - fref("/01-programming-language-theory/02-concepts/evaluator.td")
books:
  - fref("/01-programming-language-theory/01-books/04-programming-languages-application-and-interpretation/02-chapter-2-evaluation.td")
tags:
  - 'programming language basic'
---

::: flashcard
The relation between an evaluator and an interpreter?
=== key
- An interpreter is a program that simulates the execution of a programming language and implements a function that carries a program into a value.
- An evaluator is a program that reduces a program into a value.
- Essentially, the line is pretty blurry:
  - **Interpreter** sometimes emphasizes the *operational* aspect: stepping through a program instruction by instruction, maintaining state, simulating a machine.
  - **Evaluator** sometimes emphasizes the *denotational* or *reduction* aspect: recursively computing the value of expressions according to semantic rules.
  - But in reality, most interpreters *are* evaluators.
- Some subtle connotations that occasionally appear:
  - "Evaluator" might suggest a simpler, more mathematical framing (common in PL theory, lambda calculus).
  - "Interpreter" might suggest something more full-featured: handling I/O, errors, a REPL, etc.
  - In partial evaluation literature, an "evaluator" is specifically the semantic function being specialized.
:::
