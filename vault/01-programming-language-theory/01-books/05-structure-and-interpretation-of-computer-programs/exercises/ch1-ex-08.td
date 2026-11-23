---
_type: PltBook
_label: 'Exercise 1.8: Cube root using Newton method'
parent: fref("/01-programming-language-theory/01-books/05-structure-and-interpretation-of-computer-programs/01-chapter-1-building-abstractions-with-procedures.td")
journey: fref("/01-programming-language-theory/index.td")
url: "https://web.mit.edu/6.001/6.037/sicp.pdf"
status: "Finished"
---

**Question**: Newton's method for cube roots: if `y` is an approximation to the cube root of `x`, then a better approximation is `(x/y² + 2y)/3`. Implement a cube-root procedure analogous to `sqrt`.

**Answer**:

```scheme
(define (cuber x)
  (define (cuber-iter guess)
    (if (good-enough? guess)
      guess
      (cuber-iter (improve guess))))
  (define (good-enough? guess)
    (< (abs (- (* guess guess guess) x)) 0.0001))
  (define (improve guess)
    (/ (+ (/ x (* guess guess))
          (* 2.0 guess))
        3.0))
  (cuber-iter 1.0))
```
