---
_type: PltBook
_label: 'Exercise 2.8: Interval subtraction'
parent: fref("/01-programming-language-theory/01-books/05-structure-and-interpretation-of-computer-programs/02-chapter-2-building-abstractions-with-data.td")
journey: fref("/01-programming-language-theory/index.td")
url: "https://web.mit.edu/6.001/6.037/sicp.pdf"
status: "Finished"
---

**Question**: Define `sub-interval` for subtracting two intervals.

**Answer**: The difference `i1 - i2` has:
- Lower bound: `lower(i1) - upper(i2)` (minimum possible value)
- Upper bound: `upper(i1) - lower(i2)` (maximum possible value)

```scheme
(define (sub-interval x y)
  (make-interval (- (lower-bound x) (upper-bound y))
                 (- (upper-bound x) (lower-bound y))))
```
