---
_type: PltFlashcard
_label: 'What is sequential let?'
concepts:
  - fref("/01-programming-language-theory/02-concepts/cascading-sequential-let.td")
books:
  - fref("/01-programming-language-theory/01-books/04-programming-languages-application-and-interpretation/01-chapter-1-learning-smol-standard-model-of-languages.td")
tags:
  - 'programming language basic'
---

::: flashcard{deck="01-Programming Language Basics"}
What is sequential let?
=== key
Sequential let, as in Scheme, is a syntactic construct in which any preceding local binding in the same let clause is visible in the later binding definitions (not including itself) and the let body.

```scheme
(let ([x 1])
	(let* ([x (+ x 1)] ; 2
				 [y x]) ; 2
		x + y)) ; 4
```
:::
