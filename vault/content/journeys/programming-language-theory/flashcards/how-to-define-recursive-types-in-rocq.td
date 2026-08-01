---
_type: Flashcard
question: "How to define recursive types in rocq?"
deck: 'rocq-programming-language'
concepts:
  - fref("journeys/programming-language-theory/concepts/recursive-type.td")
books:
  - fref("journeys/programming-language-theory/books/software-foundations/chapter-1-basics-functional-programming-in-rocq.td")
---

::: flashcard
${question}
=== key
Just use the `Inductive` type definition. For example:

```coq
Inductive nat : Type :=
	| O
	| S (n : nat).
```
:::
