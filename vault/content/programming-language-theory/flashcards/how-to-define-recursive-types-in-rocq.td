---
_type: Flashcard
deck: 'rocq-programming-language'
concepts:
  - fref("programming-language-theory/concepts/recursive-type.td")
books:
  - fref("programming-language-theory/books/software-foundations/chapter-1-basics-functional-programming-in-rocq.td")
---

::: flashcard
How to define recursive types in rocq?
=== key
Just use the `Inductive` type definition. For example:

```coq
Inductive nat : Type :=
	| O
	| S (n : nat).
```
:::
