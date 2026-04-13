---
author: hdnax
createdAt: "2026-03-28"
updatedAt: "2026-03-28"
question: "How to define a days-of-week data type in rocq?"
answer: TODO
deck: rocq-programming-language
concepts:
  - rocq
books:
  - chapter-1-basics-functional-programming-in-rocq
tags: []
keywords:
  - "rocq"
  - "coq"
  - "inductive"
  - "day"
  - "type"
  - "monday"
  - "tuesday"
---
author: hdnax


```coq
Inductive day : Type :=
	| monday
	| tuesday
	| wednesday
	| thursday
	| friday
	| saturday
	| sunday.
```
