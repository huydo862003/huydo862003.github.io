---
_type: PltFlashcard
_label: 'How to define multi-argument functions in rocq?'
concepts:
  - fref("/01-programming-language-theory/02-concepts/rocq.td")
books:
  - fref("/01-programming-language-theory/01-books/03-software-foundations/01-logical-foundations/01-chapter-1-basics-functional-programming-in-rocq/index.td")
tags:
  - 'rocq programming language'
---

::: flashcard{deck="14-Rocq Programming Language"}
How to define multi-argument functions in rocq?
=== key
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
:::
