---
_type: PltConcept
_label: 'Recursive let'
phase: fref("/01-programming-language-theory/phases/phase-01-foundations-of-program-specification-and-semantics.td")
journey: fref("/01-programming-language-theory/index.td")
status: 'learning'
tags:
  - 'language feature/design'
  - 'syntax & grammar'
---

```scheme
(letrec ([fact (lambda (n)
                 (if (= n 0) 1 (* n (fact (- n 1)))))])
  (fact 5))
; => 120
```
