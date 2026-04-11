---
createdAt: "2026-03-28"
updatedAt: "2026-03-28"
question: What is sequential let?
answer: TODO
deck: programming-language-basic
concepts:
  - cascading-sequential-let
books:
  - chapter-1-learning-smol-standard-model-of-languages
tags:
  - "cascading sequential let"
  - "scheme"
  - "binding"
  - "sequential"
  - "syntactic"
  - "construct"
  - "preceding"
---


Sequential let, as in Scheme, is a syntactic construct in which any preceding local binding in the same let clause is visible in the later binding definitions (not including itself) and the let body.

```scheme
(let ([x 1])
	(let* ([x (+ x 1)] ; 2
				 [y x]) ; 2
		x + y)) ; 4
```
