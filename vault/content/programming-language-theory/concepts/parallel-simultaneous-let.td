---
_type: Concept
_label: 'Parallel/Simultaneous let'
title: 'Parallel/Simultaneous let'
journey: fref("programming-language-theory/index.td")
status: 'learning'
books:
  - fref("programming-language-theory/books/programming-languages-application-and-interpretation/chapter-1-learning-smol-standard-model-of-languages.td")
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
