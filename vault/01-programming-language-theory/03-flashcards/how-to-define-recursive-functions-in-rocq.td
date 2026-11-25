---
_type: PltFlashcard
_label: 'How to define recursive functions in rocq?'
concepts:
  - fref("/01-programming-language-theory/02-concepts/fixed-point-combinator.td")
books:
  - fref("/01-programming-language-theory/01-books/03-software-foundations/01-logical-foundations/01-chapter-1-basics-functional-programming-in-rocq/index.td")
tags:
  - 'rocq programming language'
---

::: flashcard{deck="14-Rocq Programming Language"}
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
