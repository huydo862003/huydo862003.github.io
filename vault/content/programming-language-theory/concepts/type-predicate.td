---
_type: Concept
_label: 'Type predicate'
title: 'Type predicate'
journey: fref("programming-language-theory/index.td")
status: 'mastered'
books:
  - fref("programming-language-theory/books/programming-languages-application-and-interpretation/chapter-5-types.td")
tags:
  - 'language-feature-design'
  - 'program-analysis'
  - 'runtime'
  - 'semantics'
  - 'type-theory'
---

A function that tests whether a value belongs to a specific type and informs the ${fref("programming-language-theory/concepts/type-checker.td")} of this fact - enables ${fref("programming-language-theory/concepts/type-narrowing.td")} after the check (e.g., mt?, string?, typeof).

A function that tests whether a value belongs to a specific type and **informs the type checker** of this fact - enables narrowing after the check (e.g., `mt?`, `string?`, `typeof`).
