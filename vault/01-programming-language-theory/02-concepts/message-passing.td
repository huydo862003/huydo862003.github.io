---
_type: PltConcept
_label: 'Message passing'
journey: fref("/01-programming-language-theory/index.td")
status: 'mastered'
books: vault.from_node(self).follow_back(PltBook, "concepts").to_list()
tags:
  - 'concurrency theory'
  - 'design principle'
  - 'programming paradigm'
tags:
  - 'concurrency theory'
  - 'design principle'
  - 'programming paradigm'
flashcards: vault.from_node(self).follow_back(PltFlashcard, "concepts").to_list()
---

```scheme
(define msg (obj name . args)
	((obj name) args))
```
