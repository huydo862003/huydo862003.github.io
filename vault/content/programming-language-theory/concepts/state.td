---
_type: Concept
_label: 'State'
title: 'State'
journey: fref("programming-language-theory/index.td")
status: 'reviewing'
books:
  - fref("programming-language-theory/books/types-and-programming-languages/chapter-3-untyped-arithmetic-expressions.td")
  - fref("programming-language-theory/books/programming-languages-application-and-interpretation/chapter-4-objects.td")
tags:
  - 'computation-theory'
  - 'language-feature-design'
  - 'program-analysis'
  - 'semantics'
---

The complete configuration of an ${fref("programming-language-theory/concepts/abstract-machine.td")} at a point during evaluation, comprising the current term and any auxiliary data (e.g., ${fref("programming-language-theory/concepts/environment.td")}, store, stack). In ${fref("programming-language-theory/concepts/pure-untyped-lambda-calculus.td")}, the state is simply a ${fref("programming-language-theory/concepts/lambda-term.td")}.
