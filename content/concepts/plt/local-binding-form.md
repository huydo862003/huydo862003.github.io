---
published: true
author: Hdnax
createdAt: "2026-03-28"
updatedAt: "2026-03-28"
title: Local binding form
journey: plt
status: learning
books:
  - chapter-1-learning-smol-standard-model-of-languages
dependsOn: []
blocks: []
tags: []
---

; Local binding - x only exists inside the let

```scheme
; Local binding - x only exists inside the let
(let ([x 10])
  (+ x 1))
; => 11

x  ; Error: x is undefined here
```
