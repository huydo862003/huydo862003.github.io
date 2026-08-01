---
_type: Concept
title: 'Parenthetical language'
journey: fref("journeys/programming-language-theory/index.td")
status: 'learning'
books:
  - fref("journeys/programming-language-theory/books/programming-languages-application-and-interpretation/chapter-3-syntactic-sugar.td")
tags:
  - 'language-feature-design'
  - 'metaprogramming-self-reflection'
  - 'syntax-grammar'
---

(define-syntax-rule (or a b) (if a a b))

```scheme
(define-syntax-rule (or a b) (if a a b))
(or x y) -> (if x x y)   ; macro just rearranges list elements
```
