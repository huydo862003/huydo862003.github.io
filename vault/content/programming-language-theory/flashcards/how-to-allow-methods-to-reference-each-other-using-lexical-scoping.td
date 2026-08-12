---
_type: Flashcard
deck: 'general'
books:
  - fref("programming-language-theory/books/programming-languages-application-and-interpretation/chapter-4-objects.td")
---

::: flashcard
How to allow methods to reference each other using lexical scoping?
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
