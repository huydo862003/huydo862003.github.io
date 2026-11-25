---
_type: PltFlashcard
_label: 'How to define recursive types in rocq?'
concepts:
  - fref("/01-programming-language-theory/02-concepts/recursive-type.td")
books:
  - fref("/01-programming-language-theory/01-books/03-software-foundations/01-logical-foundations/01-chapter-1-basics-functional-programming-in-rocq/index.td")
tags:
  - 'rocq programming language'
---

::: flashcard{deck="14-Rocq Programming Language"}
How to define recursive types in rocq?
=== key
Just use the `Inductive` type definition. For example:

```coq
Inductive nat : Type :=
	| O
	| S (n : nat).
```
:::
