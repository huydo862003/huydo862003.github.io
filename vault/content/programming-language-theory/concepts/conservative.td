---
_type: Concept
title: 'Conservative'
journey: fref("programming-language-theory/index.td")
status: 'mastered'
books:
  - fref("programming-language-theory/books/programming-languages-application-and-interpretation/chapter-5-types.td")
tags:
  - 'compiler-implementation'
  - 'language-feature-design'
  - 'type-theory'
---

A type checker that considers all possible executions rather than just actual ones - may reject programs that would run safely (false positives) because it can't know which branch will execute at runt

A type checker that considers **all possible executions** rather than just actual ones - may reject programs that would run safely (false positives) because it can't know which branch will execute at runtime.
