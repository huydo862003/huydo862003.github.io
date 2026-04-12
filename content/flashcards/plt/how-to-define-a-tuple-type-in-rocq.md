---
createdAt: "2026-03-28"
updatedAt: "2026-03-28"
question: "How to define a tuple type in rocq?"
answer: TODO
deck: rocq-programming-language
concepts:
  - rocq
books:
  - chapter-1-basics-functional-programming-in-rocq
tags: []
keywords:
  - "rocq"
  - "multiple"
  - "fields"
  - "inside"
  - "constructor"
  - "coq"
  - "inductive"
---


Multiple fields inside a constructor.

```coq
Inductive nybble : Type :=
	| bits (b1 b2 b3 b4 : bit)
```
