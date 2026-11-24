---
_type: PltBook
_label: 'Exercise 1.3: Sum of squares of two larger numbers'
parent: fref("/01-programming-language-theory/01-books/05-structure-and-interpretation-of-computer-programs/01-chapter-1-building-abstractions-with-procedures/index.td")
journey: fref("/01-programming-language-theory/index.td")
url: "https://web.mit.edu/6.001/6.037/sicp.pdf"
status: "Finished"
---

**Question**: Define a procedure that takes three numbers as arguments and returns the sum of the squares of the two larger numbers.

**Answer**:

```scheme
(define (sum-of-square-max-pair x y z)
  (define (square x) (* x x))
  (cond ((and (< x y) (< x z)) (+ (square y) (square z)))
        ((and (< y x) (< y z)) (+ (square x) (square z)))
        (else (+ (square x) (square y)))))
```
