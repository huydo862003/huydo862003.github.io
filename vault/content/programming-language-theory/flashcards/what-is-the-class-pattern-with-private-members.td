---
_type: Flashcard
_label: 'What is the class pattern with private members?'
deck: 'language-theory'
concepts:
  - fref("programming-language-theory/concepts/class-pattern.td")
books:
  - fref("programming-language-theory/books/programming-languages-application-and-interpretation/chapter-4-objects.td")
---

::: flashcard
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
