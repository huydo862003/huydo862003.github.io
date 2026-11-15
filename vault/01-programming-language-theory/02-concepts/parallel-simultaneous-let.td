---
_type: PltConcept
_label: 'Parallel/Simultaneous let'
phase: fref("/01-programming-language-theory/phases/phase-01-foundations-of-program-specification-and-semantics.td")
journey: fref("/01-programming-language-theory/index.td")
status: 'learning'
books: vault.from_node(self).follow_back(PltBook, "concepts").to_list()
tags:
  - 'language feature/design'
  - 'syntax & grammar'
flashcards: vault.from_node(self).follow_back(PltFlashcard, "concepts").to_list()
---

```scheme
(let ([x 1]
      [y (+ x 1)])  ; this x refers to outer scope, not the x being bound
  (+ x y))
; Error if no outer x exists
```

Python's multi-assignment's semantic is similar to parallel let:

```python
x = 1
y = 2
x, y = y, x + y
## X => 2, y => 3
## RHS evaluated first: (2, 1+2) => (2, 3)
## Then both assigned simultaneously
```
