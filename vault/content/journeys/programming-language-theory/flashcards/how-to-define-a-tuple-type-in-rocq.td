---
_type: Flashcard
question: "How to define a tuple type in rocq?"
deck: 'rocq-programming-language'
concepts:
  - fref("journeys/programming-language-theory/concepts/rocq.td")
books:
  - fref("journeys/programming-language-theory/books/software-foundations/chapter-1-basics-functional-programming-in-rocq.td")
---

::: flashcard
${question}
=== key
Multiple fields inside a constructor.

```coq
Inductive nybble : Type :=
	| bits (b1 b2 b3 b4 : bit)
```
:::
