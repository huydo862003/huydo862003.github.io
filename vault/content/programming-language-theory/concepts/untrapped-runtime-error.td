---
_type: Concept
_label: 'Untrapped (runtime) error'
title: 'Untrapped (runtime) error'
journey: fref("programming-language-theory/index.td")
status: 'reviewing'
books:
  - fref("programming-language-theory/books/types-and-programming-languages/chapter-1-introduction.td")
tags:
  - 'language-feature-design'
  - 'runtime'
  - 'type-theory'
---

According to "Type system" [Luca Cardelli, 1996], a type of errors that does not terminate the program, such as buffer overflows, accessing deallocated memory, type punning gone wrong. These are deemed as dangerous as they can corrupt the program's state.
