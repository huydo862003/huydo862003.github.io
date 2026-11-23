---
_type: PltBook
_label: 'Exercise 2.10: Divide-by-zero check for intervals'
parent: fref("/01-programming-language-theory/01-books/05-structure-and-interpretation-of-computer-programs/02-chapter-2-building-abstractions-with-data.td")
journey: fref("/01-programming-language-theory/index.td")
url: "https://web.mit.edu/6.001/6.037/sicp.pdf"
status: "Finished"
---

**Question**: Modify `div-interval` to signal an error if the divisor interval spans zero.

**Answer**: An interval spans zero if its lower bound is ≤ 0 and upper bound is ≥ 0.

```scheme
(define (div-interval x y)
  (if (and (<= (lower-bound y) 0) (>= (upper-bound y) 0))
    (error "Divisor spans 0")
    (mul-interval
      x
      (make-interval (/ 1.0 (upper-bound y))
                     (/ 1.0 (lower-bound y))))))
```
