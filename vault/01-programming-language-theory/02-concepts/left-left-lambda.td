---
_type: PltConcept
_label: 'Left-left-lambda'
journey: fref("/01-programming-language-theory/index.td")
status: 'mastered'
books: vault.from_node(self).follow_back(PltBook, "concepts").to_list()
tags:
  - 'language feature/design'
  - 'programming paradigm'
  - 'syntax & grammar'
flashcards: vault.from_node(self).follow_back(PltFlashcard, "concepts").to_list()
---

```scheme
((lambda (x) body) arg)
│││
│││
│└┴── lambda
└┴─── left left (two opening parens)
```

Reading left-to-right: `(` `(` `lambda` -> "left-left-lambda".
