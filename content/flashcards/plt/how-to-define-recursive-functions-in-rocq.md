---
published: true
author: Hdnax
createdAt: "2026-03-28"
updatedAt: "2026-03-28"
question: How to define recursive functions in rocq?
deck: rocq-programming-language
concepts:
  - fixed-point-combinator
books:
  - chapter-1-basics-functional-programming-in-rocq
tags: []
---

Use the `Fixpoint` definition. For example:

```coq
Fixpoint even (n : nat) : bool :=
	match n with
		| O => true
		| S O => false
		| S (S n') => even n'
	end.
```
