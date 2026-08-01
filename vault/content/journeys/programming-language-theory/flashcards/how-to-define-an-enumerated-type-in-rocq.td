---
_type: Flashcard
question: "How to define an enumerated type in rocq?"
deck: 'rocq-programming-language'
concepts:
  - fref("journeys/programming-language-theory/concepts/enumerated-type.td")
books:
  - fref("journeys/programming-language-theory/books/software-foundations/chapter-1-basics-functional-programming-in-rocq.td")
---

::: flashcard
${question}
=== key
Use the `Inductive` keyword:

```coq
Inductive nat : Type :=
	| O
	| S (n : nat).
```
:::
