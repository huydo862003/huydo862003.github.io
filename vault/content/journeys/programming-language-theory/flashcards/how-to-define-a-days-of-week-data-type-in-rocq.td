---
_type: Flashcard
deck: 'rocq-programming-language'
concepts:
  - fref("journeys/programming-language-theory/concepts/rocq.td")
books:
  - fref("journeys/programming-language-theory/books/software-foundations/chapter-1-basics-functional-programming-in-rocq.td")
---

::: flashcard
How to define a days-of-week data type in rocq?
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
