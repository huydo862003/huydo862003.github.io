---
_type: PltBook
_label: 'Exercise 1.11: Recursive and iterative f(n)'
parent: fref("/01-programming-language-theory/01-books/05-structure-and-interpretation-of-computer-programs/01-chapter-1-building-abstractions-with-procedures/index.td")
journey: fref("/01-programming-language-theory/index.td")
url: "https://web.mit.edu/6.001/6.037/sicp.pdf"
status: "Finished"
---

**Question**: A function `f` is defined by: `f(n) = n` if `n < 3`; `f(n) = f(n-1) + 2f(n-2) + 3f(n-3)` if `n ≥ 3`. Write both a recursive and an iterative procedure.

**Answer**:

Recursive version (direct translation of the rule):

```scheme
(define (f n)
  (if (< n 3)
    n
    (+ (f (- n 1))
       (* 2 (f (- n 2)))
       (* 3 (f (- n 3))))))
```
