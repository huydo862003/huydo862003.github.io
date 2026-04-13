---
author: hdnax
createdAt: "2026-03-28"
updatedAt: "2026-03-28"
title: Parallel/Simultaneous let
description: "[y (+ x 1)])  ; this x refers to outer scope, not the x being bound"
journey: plt
status: learning
books:
  - chapter-1-learning-smol-standard-model-of-languages
dependsOn: []
blocks: []
tags: []
keywords:
  - "parallel"
  - "outer"
  - "simultaneous"
  - "scheme"
  - "refers"
  - "scope"
  - "bound"
  - "error"
  - "exists"
  - "python's"
  - "multi-assignment's"
---
author: hdnax

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
# x => 2, y => 3
# RHS evaluated first: (2, 1+2) => (2, 3)
# Then both assigned simultaneously
```
