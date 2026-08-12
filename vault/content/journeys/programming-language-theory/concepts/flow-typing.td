---
_type: Concept
title: 'Flow typing'
journey: fref("journeys/programming-language-theory/index.td")
status: 'mastered'
books:
  - fref("journeys/programming-language-theory/books/programming-languages-application-and-interpretation/chapter-5-types.td")
tags:
  - 'language-feature-design'
  - 'program-analysis'
  - 'runtime'
  - 'semantics'
  - 'type-theory'
---

A type system feature where a variable's type changes based on control flow - after if (x != null), the type of x narrows from T | null to T.

A type system feature where a variable's type **changes** based on control flow - after `if (x != null)`, the type of `x` narrows from `T | null` to `T`.
