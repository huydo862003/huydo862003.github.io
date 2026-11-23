---
_type: PltBook
_label: 'Exercise 1.1: Evaluating expressions'
parent: fref("/01-programming-language-theory/01-books/05-structure-and-interpretation-of-computer-programs/01-chapter-1-building-abstractions-with-procedures.td")
journey: fref("/01-programming-language-theory/index.td")
url: "https://web.mit.edu/6.001/6.037/sicp.pdf"
status: "Finished"
---

**Question**: What is the result printed by the interpreter in response to each of the following expressions?

```scheme
10
(+ 5 3 4)
(- 9 1)
(/ 6 2)
(+ (* 2 4) (- 4 6))
(define a 3)
(define b (+ a 1))
(+ a b (* a b))
(= a b)
(if (and (> b a) (< b (* a b)))
b
a)
(cond ((= a 4) 6)
((= b 4) (+ 6 7 a))
(else 25))
(+ 2 (if (> b a) b a))
(* (cond ((> a b) a)
((< a b) b)
(else -1))
(+ a 1))
```

**Answer**:

```scheme
10                                  ; 10
(+ 5 3 4)                           ; 12
(- 9 1)                             ; 8
(/ 6 2)                             ; 3
(+ (* 2 4) (- 4 6))                 ; 6
(define a 3)
(define b (+ a 1))
(+ a b (* a b))                     ; 19
(= a b)                             ; #f
(if (and (> b a) (< b (* a b)))
b
a)                                  ; 4
(cond ((= a 4) 6)
((= b 4) (+ 6 7 a))
(else 25))                          ; 16
(+ 2 (if (> b a) b a))              ; 6
(* (cond ((> a b) a)
((< a b) b)
(else -1))
(+ a 1))                            ; 16
```
