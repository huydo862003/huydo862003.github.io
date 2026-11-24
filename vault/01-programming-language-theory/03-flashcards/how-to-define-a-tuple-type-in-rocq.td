---
_type: PltFlashcard
_label: 'How to define a tuple type in rocq?'
concepts:
  - fref("/01-programming-language-theory/02-concepts/rocq.td")
books:
  - fref("/01-programming-language-theory/01-books/03-software-foundations/01-logical-foundations/01-chapter-1-basics-functional-programming-in-rocq/index.td")
tags:
  - 'rocq programming language'
---

::: flashcard{deck="rocq programming language"}
How to define a tuple type in rocq?
=== key
Multiple fields inside a constructor.

```coq
Inductive nybble : Type :=
	| bits (b1 b2 b3 b4 : bit)
```
:::
