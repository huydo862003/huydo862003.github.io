---
author: hdnax
createdAt: "2026-03-28"
updatedAt: "2026-03-28"
title: Object pattern
description: "\"Object pattern\" is a concept in plt (status: learning)."
journey: plt
status: learning
books:
  - chapter-4-objects
dependsOn: []
blocks: []
tags: []
keywords:
  - "lambda"
  - "prop1"
  - "prop2"
  - "object"
  - "pattern"
  - "scheme"
  - "case"
---
author: hdnax

```scheme
(define o
	(let ([prop1 (...)]
				[prop2 (...)])
		(lambda (m)
			(case m
				[(first) (lambda () prop1)]
				[(second) (lambda () prop2)])))
```
