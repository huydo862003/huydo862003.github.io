---
_type: PltConcept
_label: 'Garbage collection'
phase: fref("/01-programming-language-theory/phases/phase-01-foundations-of-program-specification-and-semantics.td")
journey: fref("/01-programming-language-theory/index.td")
status: 'mastered'
tags:
  - 'language feature/design'
  - 'runtime'
---

An ${fref("/01-programming-language-theory/02-concepts/automatic-memory-management.td")} technique that identifies and reclaims ${fref("/01-programming-language-theory/02-concepts/heap.td")}-allocated memory no longer reachable by the program, freeing the programmer from explicit deallocation and preventing memory leaks and dangling references.
