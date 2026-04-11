---
createdAt: "2026-03-28"
updatedAt: "2026-03-28"
question: How to allow methods to reference each other using lexical scoping?
answer: TODO
deck: general
concepts: []
books:
  - chapter-4-objects
tags:
  - "self"
  - "lambda"
  - "mutation"
  - "racket"
  - "mk-obj"
  - "args"
---


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
