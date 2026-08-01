---
_type: Flashcard
question: "What is the class pattern with both private members and static members?"
deck: 'general'
books:
  - fref("journeys/programming-language-theory/books/programming-languages-application-and-interpretation/chapter-4-objects.td")
---

::: flashcard
${question}
=== key
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
:::
