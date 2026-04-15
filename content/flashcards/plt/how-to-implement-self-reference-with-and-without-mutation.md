---
published: true
author: hdnax
createdAt: "2026-03-28"
updatedAt: "2026-03-28"
question: How to implement self-reference with and without mutation?
deck: general
concepts: []
books:
  - chapter-4-objects
tags: []
---

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
