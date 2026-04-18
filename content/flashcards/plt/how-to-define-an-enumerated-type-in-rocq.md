---
published: true
author: Hdnax
createdAt: "2026-03-28"
updatedAt: "2026-03-28"
question: How to define an enumerated type in rocq?
deck: rocq-programming-language
concepts:
  - enumerated-type
books:
  - chapter-1-basics-functional-programming-in-rocq
tags: []
---

Use the `Inductive` keyword:

```coq
Inductive nat : Type :=
	| O
	| S (n : nat).
```
