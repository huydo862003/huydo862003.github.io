---
_type: PltConcept
_label: 'Cascading/Sequential let'
phase: fref("/01-programming-language-theory/phases/phase-01-foundations-of-program-specification-and-semantics.td")
journey: fref("/01-programming-language-theory/index.td")
status: 'learning'
tags:
  - 'language feature/design'
  - 'syntax & grammar'
---

```scheme
(let* ([x 1]
       [y (+ x 1)]   ; sees x bound to 1
       [z (+ y 1)])  ; sees y bound to 2
  z)
; => 3
```
