---
_type: Flashcard
question: "How to define a days-of-week data type in rocq?"
deck: 'rocq-programming-language'
concepts:
  - fref("journeys/programming-language-theory/concepts/rocq.td")
books:
  - fref("journeys/programming-language-theory/books/software-foundations/chapter-1-basics-functional-programming-in-rocq.td")
---

::: flashcard
${question}
=== key
```coq
Inductive day : Type :=
	| monday
	| tuesday
	| wednesday
	| thursday
	| friday
	| saturday
	| sunday.
```
:::
