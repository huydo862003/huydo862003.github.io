---
_type: PltBook
_label: 'Exercise 1.5: Applicative vs normal order test'
parent: fref("/01-programming-language-theory/01-books/05-structure-and-interpretation-of-computer-programs/01-chapter-1-building-abstractions-with-procedures/index.td")
journey: fref("/01-programming-language-theory/index.td")
url: "https://web.mit.edu/6.001/6.037/sicp.pdf"
status: "Finished"
---

**Question**: Ben Bitdiddle defines:

```scheme
(define (p) (p))
(define (test x y)
  (if (= x 0) 0 y))
```

What behavior will Ben observe with applicative-order evaluation vs normal-order evaluation when evaluating `(test 0 (p))`?

**Answer**: Note that `if` is short-circuiting regardless of evaluation order.

**Applicative-order evaluation** (evaluate all arguments first):
1. Evaluate `0` → `0`.
2. Evaluate `(p)` → `(p)` → loops indefinitely.

The interpreter hangs.

**Normal-order evaluation** (substitute before evaluating):
1. Substitute `0` and `(p)` into the body of `test`.
2. `(if (= 0 0) 0 (p))` → evaluates predicate `(= 0 0)` → `#t` → returns `0`.

The interpreter returns `0`.

Therefore, Ben can determine:
- Loops indefinitely → applicative-order evaluation.
- Returns `0` → normal-order evaluation.
