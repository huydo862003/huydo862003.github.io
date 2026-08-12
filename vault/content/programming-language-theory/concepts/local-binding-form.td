---
_type: Concept
title: 'Local binding form'
journey: fref("programming-language-theory/index.td")
status: 'learning'
books:
  - fref("programming-language-theory/books/programming-languages-application-and-interpretation/chapter-1-learning-smol-standard-model-of-languages.td")
---

; Local binding - x only exists inside the let

```scheme
; Local binding - x only exists inside the let
(let ([x 10])
  (+ x 1))
; => 11

x  ; Error: x is undefined here
```
