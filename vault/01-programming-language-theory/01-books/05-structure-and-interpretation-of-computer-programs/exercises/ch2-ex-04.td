---
_type: PltBook
_label: 'Exercise 2.4: Procedural representation of pairs'
parent: fref("/01-programming-language-theory/01-books/05-structure-and-interpretation-of-computer-programs/02-chapter-2-building-abstractions-with-data.td")
journey: fref("/01-programming-language-theory/index.td")
url: "https://web.mit.edu/6.001/6.037/sicp.pdf"
status: "Finished"
---

**Question**: Given this alternative procedural representation of pairs:

```scheme
(define (cons x y) (lambda (m) (m x y)))
(define (car z) (z (lambda (p q) p)))
```

Verify that `(car (cons x y))` yields `x`. What is the corresponding `cdr`?

**Answer**:

Verification:
```scheme
(car (cons x y))
(car (lambda (m) (m x y)))
((lambda (m) (m x y)) (lambda (p q) p))
((lambda (p q) p) x y)
x
```

Corresponding `cdr`:
```scheme
(define (cdr z)
  (z (lambda (p q) q)))
```
