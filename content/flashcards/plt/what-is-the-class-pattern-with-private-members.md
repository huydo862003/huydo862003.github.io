---
published: true
author: hdnax
createdAt: "2026-03-28"
updatedAt: "2026-03-28"
question: What is the class pattern with private members?
deck: language-theory
concepts:
  - class-pattern
books:
  - chapter-4-objects
tags: []
---

```racket
(define (cls args)
	(let ([priv_1 exp_1]
				[...])
		(lambda (m)
			(case (m)
				[]
				[]))))
```
