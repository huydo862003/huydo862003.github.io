---
published: true
author: hdnax
createdAt: "2026-03-28"
updatedAt: "2026-03-28"
title: Object pattern
journey: plt
status: learning
books:
  - chapter-4-objects
dependsOn: []
blocks: []
tags: []
---

```scheme
(define o
	(let ([prop1 (...)]
				[prop2 (...)])
		(lambda (m)
			(case m
				[(first) (lambda () prop1)]
				[(second) (lambda () prop2)])))
```
