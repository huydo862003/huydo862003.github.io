---
_type: Flashcard
_label: 'How to implement open recursion with self-application?'
deck: 'pure-lambda-calculus'
books:
  - fref("programming-language-theory/books/programming-languages-application-and-interpretation/chapter-4-objects.td")
---

::: flashcard
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
