---
_type: Flashcard
_label: 'How to define recursive functions in rocq?'
deck: 'rocq-programming-language'
concepts:
  - fref("programming-language-theory/concepts/fixed-point-combinator.td")
books:
  - fref("programming-language-theory/books/software-foundations/chapter-1-basics-functional-programming-in-rocq.td")
---

::: flashcard
How to define recursive functions in rocq?
=== key
Use the `Fixpoint` definition. For example:

```coq
Fixpoint even (n : nat) : bool :=
	match n with
		| O => true
		| S O => false
		| S (S n') => even n'
	end.
```
:::
