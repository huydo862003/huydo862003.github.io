---
_type: Concept
title: 'Trapped (runtime) error'
journey: fref("programming-language-theory/index.td")
status: 'reviewing'
books:
  - fref("programming-language-theory/books/types-and-programming-languages/chapter-1-introduction.td")
tags:
  - 'language-feature-design'
  - 'runtime'
  - 'type-theory'
---

According to "Type system" [Luca Cardelli, 1996], a type of errors that immediately terminate the program, such as division by zero, array index out-of-bound (in Java, Rust, etc.). These are deemed as safe as they cannot corrupt the program's state.
