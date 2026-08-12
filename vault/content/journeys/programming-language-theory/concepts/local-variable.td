---
_type: Concept
title: 'Local variable'
journey: fref("journeys/programming-language-theory/index.td")
status: 'mastered'
books:
  - fref("journeys/programming-language-theory/books/programming-languages-application-and-interpretation/chapter-1-learning-smol-standard-model-of-languages.td")
tags:
  - 'language-feature-design'
  - 'semantics'
---

A variable declared within a ${fref("journeys/programming-language-theory/concepts/block.td")} or function whose ${fref("journeys/programming-language-theory/concepts/scope.td")} and ${fref("journeys/programming-language-theory/concepts/lifetime.td")} are limited to that region - inaccessible from outside and typically deallocated when the block exits.
