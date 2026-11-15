---
_type: PltFlashcard
_label: 'How to implement self-reference with and without mutation?'
deck: 'general'
books:
  - fref("/01-programming-language-theory/01-books/04-programming-languages-application-and-interpretation/04-chapter-4-objects.td")
---

::: flashcard
How to implement self-reference with and without mutation?
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
