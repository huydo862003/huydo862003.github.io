---
published: true
author: Hdnax
createdAt: "2026-03-28"
updatedAt: "2026-03-28"
question: How to define recursive types in rocq?
deck: rocq-programming-language
concepts:
  - recursive-type
books:
  - chapter-1-basics-functional-programming-in-rocq
tags: []
---

Just use the `Inductive` type definition. For example:

```coq
Inductive nat : Type :=
	| O
	| S (n : nat).
```
