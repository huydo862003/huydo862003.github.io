---
author: hdnax
createdAt: "2026-03-28"
updatedAt: "2026-03-28"
question: How to implement open recursion with self-application?
answer: TODO
deck: pure-lambda-calculus
concepts: []
books:
  - chapter-4-objects
tags: []
keywords:
  - "lambda"
  - "self"
  - "parent-maker"
  - "parent-obj"
  - "scheme"
  - "cls"
---
author: hdnax


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
