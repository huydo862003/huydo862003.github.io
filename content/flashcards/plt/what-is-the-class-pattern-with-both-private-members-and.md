---
published: true
author: Hdnax
createdAt: "2026-03-28"
updatedAt: "2026-03-28"
question: What is the class pattern with both private members and static members?
deck: general
concepts: []
books:
  - chapter-4-objects
tags: []
---

```racket
(define (cls)
	(lambda (m)
		(case (m)
			[(static_1) exp_1])
			[(new) (lambda (args)
							(lambda (m)
								(case (m)
									[]
									[])))]))
```
