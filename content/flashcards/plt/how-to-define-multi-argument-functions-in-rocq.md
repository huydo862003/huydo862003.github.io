---
published: true
author: Hdnax
createdAt: "2026-03-28"
updatedAt: "2026-03-28"
question: How to define multi-argument functions in rocq?
deck: rocq-programming-language
concepts:
  - rocq
books:
  - chapter-1-basics-functional-programming-in-rocq
tags: []
---

Use this syntax:

- `(arg1 : type1) (arg2 : type2) (arg3 : type3) : ret-type`.
- `(arg1 arg2 arg3 : type) : ret-type`.

For example:

```coq
Definition plus (n : nat) (m : nat) : nat :=
	match n with
		| O => m
		| S n' => S (plus n' m)
	end.
	
Definition mult (n m : nat) : nat :=
	match n with
		| O => O
		| S n' => (plus m (mult n' m))
	end.
```
