---
_type: PltBook
_label: 'Exercise 1.6: Why if must be a special form'
parent: fref("/01-programming-language-theory/01-books/05-structure-and-interpretation-of-computer-programs/01-chapter-1-building-abstractions-with-procedures/index.td")
journey: fref("/01-programming-language-theory/index.td")
url: "https://web.mit.edu/6.001/6.037/sicp.pdf"
status: "Finished"
---

**Question**: Alyssa P. Hacker defines `new-if` as an ordinary procedure:

```scheme
(define (new-if predicate then-clause else-clause)
  (cond (predicate then-clause)
        (else else-clause)))
```

She then rewrites `sqrt-iter` using `new-if`:

```scheme
(define (sqrt-iter guess x)
  (new-if (good-enough? guess x)
    guess
    (sqrt-iter (improve guess x) x)))
```

What happens when she attempts to use this to compute square roots?

**Answer**: Alyssa runs into infinite recursion.

- The `if` *special form* is short-circuited: the predicate is evaluated first, and only the relevant branch is evaluated.
- `new-if` is an *ordinary procedure*, so under applicative-order evaluation, all arguments - including both branches - are evaluated *before* the procedure is called.
- Therefore, `sqrt-iter` always recursively calls itself to evaluate the `else-clause` argument, regardless of `good-enough?`, causing infinite recursion.

This is why `if` must be a special form rather than a regular procedure.
