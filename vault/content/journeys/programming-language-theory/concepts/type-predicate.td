---
_type: Concept
title: 'Type predicate'
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

A function that tests whether a value belongs to a specific type and informs the ${fref("journeys/programming-language-theory/concepts/type-checker.td")} of this fact - enables ${fref("journeys/programming-language-theory/concepts/type-narrowing.td")} after the check (e.g., mt?, string?, typeof).

A function that tests whether a value belongs to a specific type and **informs the type checker** of this fact - enables narrowing after the check (e.g., `mt?`, `string?`, `typeof`).
