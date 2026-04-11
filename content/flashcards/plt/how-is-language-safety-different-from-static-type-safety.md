---
createdAt: "2026-03-28"
updatedAt: "2026-03-28"
question: How is language safety different from static type safety
answer: TODO
deck: type-theory
concepts:
  - language-safety
books:
  - chapter-1-introduction
tags:
  - "language safety"
  - "type"
  - "safety"
  - "program"
  - "static"
  - "never"
  - "language"
---


Static type safety means that if a compiler suggests that a program is free of any runtime type errors, running that program can never produce such an error.

Language safety means that an erroneous program can never corrupt the system.

Language safety = Static type check + Dynamic check.
