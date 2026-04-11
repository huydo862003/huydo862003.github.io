---
createdAt: "2026-03-28"
updatedAt: "2026-03-28"
question: How to define an enumerated type in Rocq?
answer: TODO
deck: rocq-programming-language
concepts:
  - enumerated-type
books:
  - chapter-1-basics-functional-programming-in-rocq
tags: []
keywords:
  - "enumerated type"
  - "inductive"
  - "nat"
  - "keyword"
  - "coq"
  - "type"
---


Use the `Inductive` keyword:

```coq
Inductive nat : Type :=
	| O
	| S (n : nat).
```
