---
_type: Concept
title: 'Untrapped (runtime) error'
journey: fref("journeys/programming-language-theory/index.td")
status: 'reviewing'
books:
  - fref("journeys/programming-language-theory/books/types-and-programming-languages/chapter-1-introduction.td")
tags:
  - 'language-feature-design'
  - 'runtime'
  - 'type-theory'
---

According to "Type system" [Luca Cardelli, 1996], a type of errors that does not terminate the program, such as buffer overflows, accessing deallocated memory, type punning gone wrong. These are deemed as dangerous as they can corrupt the program's state.
