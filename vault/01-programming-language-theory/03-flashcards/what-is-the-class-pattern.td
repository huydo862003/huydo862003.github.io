---
_type: PltFlashcard
_label: 'What is the class pattern?'
deck: 'language theory'
books:
  - fref("/01-programming-language-theory/01-books/04-programming-languages-application-and-interpretation/04-chapter-4-objects.td")
tags:
  - 'language theory'
---

::: flashcard
What is the class pattern?
=== key
Simple class pattern:

```racket
(define (cls args)
	(lambda (m)
		(case (m)
			[]
			[])))
```

What is the class pattern with private members?

What is the class pattern with both private members and static members?
:::
