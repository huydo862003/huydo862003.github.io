---
_type: Flashcard
question: "How to allow methods to reference each other using lexical scoping?"
deck: 'general'
books:
  - fref("journeys/programming-language-theory/books/programming-languages-application-and-interpretation/chapter-4-objects.td")
---

::: flashcard
${question}
=== key
With mutation:

```racket
(define (mk-obj args)
	(let ([self 'dummy])
		(begin
			(set! self
				(lambda (m)
					(case (m)
						[(first) (lambda (x) (self 'second x))]
						[(second) (lambda (x) x)])))
			self)))
```
:::
