---
_type: PltFlashcard
_label: 'How to define an enumerated type in rocq?'
concepts:
  - fref("/01-programming-language-theory/02-concepts/enumerated-type.td")
books:
  - fref("/01-programming-language-theory/01-books/03-software-foundations/01-logical-foundations/01-chapter-1-basics-functional-programming-in-rocq/index.td")
tags:
  - 'rocq programming language'
---

::: flashcard{deck="rocq programming language"}
How to define an enumerated type in rocq?
=== key
Use the `Inductive` keyword:

```coq
Inductive nat : Type :=
	| O
	| S (n : nat).
```
:::
