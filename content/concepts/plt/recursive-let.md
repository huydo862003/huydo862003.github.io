---
createdAt: "2026-03-28"
updatedAt: "2026-03-28"
title: Recursive let
journey: plt
status: learning
tags: []
books:
  - chapter-1-learning-smol-standard-model-of-languages
dependsOn: []
blocks: []
---

```scheme
(letrec ([fact (lambda (n)
                 (if (= n 0) 1 (* n (fact (- n 1)))))])
  (fact 5))
; => 120
```
