---
_type: Concept
title: 'Closed recursion'
journey: fref("programming-language-theory/index.td")
status: 'reviewing'
books:
  - fref("programming-language-theory/books/programming-languages-application-and-interpretation/chapter-4-objects.td")
tags:
  - 'design-principle'
  - 'language-feature-design'
  - 'programming-paradigm'
---

When utilizing the ${fref("programming-language-theory/concepts/class.td")} pattern to define classes with method calls referencing other methods, a recursion pattern that causes method reference to be resolved immediately right at class definition.
