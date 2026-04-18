---
published: true
author: Hdnax
createdAt: "2026-03-28"
updatedAt: "2026-03-28"
question: The relation between an evaluator and an interpreter?
deck: programming-language-basic
concepts:
  - evaluator
books:
  - chapter-2-evaluation
tags: []
---

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
