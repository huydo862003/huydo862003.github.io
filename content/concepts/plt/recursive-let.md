---
published: true
author: hdnax
createdAt: "2026-03-28"
updatedAt: "2026-03-28"
title: Recursive let
description: "\"Recursive let\" is a concept in plt (status: learning)."
journey: plt
status: learning
books:
  - chapter-1-learning-smol-standard-model-of-languages
dependsOn: []
blocks: []
tags: []
keywords:
  - "fact"
  - "recursive"
  - "scheme"
  - "letrec"
  - "lambda"
---

```scheme
(letrec ([fact (lambda (n)
                 (if (= n 0) 1 (* n (fact (- n 1)))))])
  (fact 5))
; => 120
```
