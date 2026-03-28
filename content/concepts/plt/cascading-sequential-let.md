---
createdAt: "2026-03-28"
updatedAt: "2026-03-28"
title: Cascading/Sequential let
journey: plt
status: learning
tags: []
books:
  - chapter-1-learning-smol-standard-model-of-languages
dependsOn: []
blocks: []
---

```scheme
(let* ([x 1]
       [y (+ x 1)]   ; sees x bound to 1
       [z (+ y 1)])  ; sees y bound to 2
  z)
; => 3
```
