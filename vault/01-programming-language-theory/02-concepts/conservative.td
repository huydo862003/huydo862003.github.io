---
_type: PltConcept
_label: 'Conservative'
journey: fref("/01-programming-language-theory/index.td")
status: 'mastered'
tags:
  - 'compiler implementation'
  - 'language feature/design'
  - 'type theory'
---

A type checker that considers all possible executions rather than just actual ones - may reject programs that would run safely (false positives) because it can't know which branch will execute at runt

A type checker that considers **all possible executions** rather than just actual ones - may reject programs that would run safely (false positives) because it can't know which branch will execute at runtime.
