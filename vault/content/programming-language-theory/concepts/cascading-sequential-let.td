---
_type: Concept
title: 'Cascading/Sequential let'
journey: fref("programming-language-theory/index.td")
status: 'learning'
books:
  - fref("programming-language-theory/books/programming-languages-application-and-interpretation/chapter-1-learning-smol-standard-model-of-languages.td")
---

```scheme
(let* ([x 1]
       [y (+ x 1)]   ; sees x bound to 1
       [z (+ y 1)])  ; sees y bound to 2
  z)
; => 3
```
