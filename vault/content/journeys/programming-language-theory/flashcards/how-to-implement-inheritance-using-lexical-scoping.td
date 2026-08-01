---
_type: Flashcard
question: "How to implement inheritance using lexical scoping?"
deck: 'general'
books:
  - fref("journeys/programming-language-theory/books/programming-languages-application-and-interpretation/chapter-4-objects.td")
---

::: flashcard
${question}
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
