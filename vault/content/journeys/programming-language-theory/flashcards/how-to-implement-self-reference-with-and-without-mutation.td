---
_type: Flashcard
question: "How to implement self-reference with and without mutation?"
deck: 'general'
books:
  - fref("journeys/programming-language-theory/books/programming-languages-application-and-interpretation/chapter-4-objects.td")
---

::: flashcard
${question}
=== key
With mutation:

```racket
(define (mk-self-ref)
	(let ([self 'dummy])
		(set!
			self
			(lambda (m)
				(case (m)
					[(get-self) (lambda () self)])))))
```

Without mutation:

```racket
(define (self-app x)
	(x x))

(define (mk-self-ref)
	(self-app
		(lambda (self)
			(lambda (m)
				(case (m)
					[(get-self) (lambda () self)])))))
```
:::
