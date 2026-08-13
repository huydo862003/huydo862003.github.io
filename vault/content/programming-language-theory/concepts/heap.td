---
_type: Concept
_label: 'Heap'
title: 'Heap'
journey: fref("programming-language-theory/index.td")
status: 'mastered'
books:
  - fref("programming-language-theory/books/programming-languages-application-and-interpretation/chapter-1-learning-smol-standard-model-of-languages.td")
tags:
  - 'runtime'
---

A region of a process's memory used for dynamic allocation at runtime, growing as needed and managed explicitly (via malloc/free) or by a ${fref("programming-language-theory/concepts/garbage-collection.td")} - as opposed to the stack which handles fixed-size, short-lived local variables and call frames.
