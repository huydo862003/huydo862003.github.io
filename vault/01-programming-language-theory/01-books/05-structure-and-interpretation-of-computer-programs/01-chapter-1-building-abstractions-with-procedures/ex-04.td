---
_type: PltBook
_label: 'Exercise 1.4: Operators as compound expressions'
parent: fref("/01-programming-language-theory/01-books/05-structure-and-interpretation-of-computer-programs/01-chapter-1-building-abstractions-with-procedures/index.td")
journey: fref("/01-programming-language-theory/index.td")
url: "https://web.mit.edu/6.001/6.037/sicp.pdf"
status: "Finished"
---

**Question**: Observe that our model of evaluation allows for combinations whose operators are compound expressions. Use this observation to describe the behavior of the following procedure:

```scheme
(define (a-plus-abs-b a b)
  ((if (> b 0) + -) a b))
```

**Answer**: Consider calling `(a-plus-abs-b a b)`:

1. Evaluate the operator `a-plus-abs-b` - the compound procedure above.
2. Evaluate `a` and `b`.
3. Substitute into the body: `((if (> b 0) + -) a b)`.
4. Evaluate the operator expression `(if (> b 0) + -)`:
   - If `b > 0`, the result is `+`.
   - Otherwise, the result is `-`.
5. Evaluate `a` and `b`.
6. Apply either `(+ a b)` or `(- a b)` based on step 4.

This procedure computes `a + |b|` - it always adds `a` and the absolute value of `b`.
