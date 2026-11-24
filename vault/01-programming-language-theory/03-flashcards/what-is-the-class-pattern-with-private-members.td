---
_type: PltFlashcard
_label: 'What is the class pattern with private members?'
concepts:
  - fref("/01-programming-language-theory/02-concepts/class-pattern.td")
books:
  - fref("/01-programming-language-theory/01-books/04-programming-languages-application-and-interpretation/04-chapter-4-objects.td")
tags:
  - 'language theory'
---

::: flashcard{deck="Language Theory"}
What is the class pattern with private members?
=== key
```racket
(define (cls args)
	(let ([priv_1 exp_1]
				[...])
		(lambda (m)
			(case (m)
				[]
				[]))))
```
:::
