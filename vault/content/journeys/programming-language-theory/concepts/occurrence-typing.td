---
_type: Concept
title: 'Occurrence typing'
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

A type system technique where a variable's type can differ at each occurrence (use) based on what predicates have been checked - the same variable x can have type Number in one branch and String in another. Synonymous with ${fref("journeys/programming-language-theory/concepts/flow-typing.td")}.

A type system technique where a variable's type can **differ at each occurrence** (use) based on what predicates have been checked - the same variable `x` can have type `Number` in one branch and `String` in another. Synonymous with Flow typing.
