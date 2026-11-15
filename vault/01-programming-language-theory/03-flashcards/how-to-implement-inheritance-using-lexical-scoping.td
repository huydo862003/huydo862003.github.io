---
_type: PltFlashcard
_label: 'How to implement inheritance using lexical scoping?'
deck: 'general'
books:
  - fref("/01-programming-language-theory/01-books/04-programming-languages-application-and-interpretation/04-chapter-4-objects.td")
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
