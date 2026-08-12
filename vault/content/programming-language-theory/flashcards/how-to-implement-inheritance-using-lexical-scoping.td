---
_type: Flashcard
deck: 'general'
books:
  - fref("programming-language-theory/books/programming-languages-application-and-interpretation/chapter-4-objects.td")
---

::: flashcard
How to implement inheritance using lexical scoping?
=== key
```racket
(define (cls make-parent args)
	(let ([parent (make-parent ...)])
		(lambda (m)
			(cond (m)
				[]
				[]))))
```
:::
