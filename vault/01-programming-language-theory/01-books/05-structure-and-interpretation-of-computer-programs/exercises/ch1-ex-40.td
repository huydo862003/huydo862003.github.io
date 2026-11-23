---
_type: PltBook
_label: "Exercise 1.40: Cubic polynomial for Newton's method"
parent: fref("/01-programming-language-theory/01-books/05-structure-and-interpretation-of-computer-programs/01-chapter-1-building-abstractions-with-procedures.td")
journey: fref("/01-programming-language-theory/index.td")
url: "https://web.mit.edu/6.001/6.037/sicp.pdf"
status: "Finished"
---

**Question**: Define `cubic` to be used with `newtons-method` to approximate zeros of $x^3 + ax^2 + bx + c$.

**Answer**:

```scheme
(define (cubic a b c)
  (lambda (x) (+ (* x x x)
                 (* a x x)
                 (* b x)
                 c)))
```

Usage: `(newtons-method (cubic a b c) 1)`
