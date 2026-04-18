---
published: true
author: Hdnax
createdAt: "2026-03-28"
updatedAt: "2026-03-28"
title: Cascading/Sequential let
journey: plt
status: learning
books:
  - chapter-1-learning-smol-standard-model-of-languages
dependsOn: []
blocks: []
tags: []
---

[y (+ x 1)]   ; sees x bound to 1

```scheme
(let* ([x 1]
       [y (+ x 1)]   ; sees x bound to 1
       [z (+ y 1)])  ; sees y bound to 2
  z)
; => 3
```
