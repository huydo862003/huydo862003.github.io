---
_type: PltConcept
_label: 'Local binding form'
phase: fref("/01-programming-language-theory/phases/phase-01-foundations-of-program-specification-and-semantics.td")
journey: fref("/01-programming-language-theory/index.td")
status: 'learning'
tags:
  - 'language feature/design'
  - 'syntax & grammar'
---

; Local binding - x only exists inside the let

```scheme
; Local binding - x only exists inside the let
(let ([x 10])
  (+ x 1))
; => 11

x  ; Error: x is undefined here
```
