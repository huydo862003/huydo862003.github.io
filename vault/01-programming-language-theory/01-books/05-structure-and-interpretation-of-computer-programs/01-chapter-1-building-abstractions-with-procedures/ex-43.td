---
_type: PltBook
_label: 'Exercise 1.43: Repeated function application'
parent: fref("/01-programming-language-theory/01-books/05-structure-and-interpretation-of-computer-programs/01-chapter-1-building-abstractions-with-procedures/index.td")
journey: fref("/01-programming-language-theory/index.td")
url: "https://web.mit.edu/6.001/6.037/sicp.pdf"
status: "Finished"
---

**Question**: Write `repeated` such that `((repeated f n) x)` applies `f` to `x` exactly `n` times.

**Answer**: Using `compose` from Exercise 1.42:

```scheme
(define (repeated f times)
  (if (= times 1)
    f
    (lambda (x) (compose f (repeated f (- times 1))))))
```

Example: `((repeated square 2) 5)` → `(square (square 5))` → `625`.
