---
_type: Flashcard
question: "What is the class pattern?"
deck: 'language-theory'
books:
  - fref("journeys/programming-language-theory/books/programming-languages-application-and-interpretation/chapter-4-objects.td")
---

::: flashcard
${question}
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
