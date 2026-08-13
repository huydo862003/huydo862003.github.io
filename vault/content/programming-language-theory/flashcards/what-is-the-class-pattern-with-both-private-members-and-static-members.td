---
_type: Flashcard
_label: 'What is the class pattern with both private members and static members?'
deck: 'general'
books:
  - fref("programming-language-theory/books/programming-languages-application-and-interpretation/chapter-4-objects.td")
---

::: flashcard
What is the class pattern with both private members and static members?
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
