---
_type: Flashcard
deck: 'rocq-programming-language'
concepts:
  - fref("programming-language-theory/concepts/rocq.td")
books:
  - fref("programming-language-theory/books/software-foundations/chapter-1-basics-functional-programming-in-rocq.td")
---

::: flashcard
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
