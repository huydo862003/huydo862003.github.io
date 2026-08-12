---
_type: Flashcard
question: "What is sequential let?"
deck: 'programming-language-basic'
concepts:
  - fref("journeys/programming-language-theory/concepts/cascading-sequential-let.td")
books:
  - fref("journeys/programming-language-theory/books/programming-languages-application-and-interpretation/chapter-1-learning-smol-standard-model-of-languages.td")
---

::: flashcard
${question}
=== key
Sequential let, as in Scheme, is a syntactic construct in which any preceding local binding in the same let clause is visible in the later binding definitions (not including itself) and the let body.

```scheme
(let ([x 1])
	(let* ([x (+ x 1)] ; 2
				 [y x]) ; 2
		x + y)) ; 4
```
:::
