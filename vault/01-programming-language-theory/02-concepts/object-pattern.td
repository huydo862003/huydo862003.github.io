---
_type: PltConcept
_label: 'Object pattern'
phase: fref("/01-programming-language-theory/phases/phase-01-foundations-of-program-specification-and-semantics.td")
journey: fref("/01-programming-language-theory/index.td")
status: 'mastered'
tags:
  - 'programming paradigm'
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
