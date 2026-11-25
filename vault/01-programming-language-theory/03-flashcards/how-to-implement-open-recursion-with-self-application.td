---
_type: PltFlashcard
_label: 'How to implement open recursion with self-application?'
books:
  - fref("/01-programming-language-theory/01-books/04-programming-languages-application-and-interpretation/04-chapter-4-objects.td")
tags:
  - 'pure lambda calculus'
---

::: flashcard{deck="12-Pure Lambda Calculus"}
How to implement open recursion with self-application?
=== key
```scheme
(define cls (parent-maker args)
	(let ([parent-obj (parent-maker (...))])
		(lambda (self)
			(lambda (m)
				(case m
					[(first) (lambda () (msg (self self) 'second))]
					[(second) (lambda () 4)]
					[else ((parent-obj self) m)]))))
```
:::
