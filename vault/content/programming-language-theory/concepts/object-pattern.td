---
_type: Concept
title: 'Object pattern'
journey: fref("programming-language-theory/index.td")
status: 'learning'
books:
  - fref("programming-language-theory/books/programming-languages-application-and-interpretation/chapter-4-objects.td")
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
