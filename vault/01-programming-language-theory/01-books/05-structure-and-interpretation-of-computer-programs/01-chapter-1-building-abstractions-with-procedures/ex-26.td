---
_type: PltBook
_label: 'Exercise 1.26: Why explicit multiplication breaks log complexity'
parent: fref("/01-programming-language-theory/01-books/05-structure-and-interpretation-of-computer-programs/01-chapter-1-building-abstractions-with-procedures/index.td")
journey: fref("/01-programming-language-theory/index.td")
url: "https://web.mit.edu/6.001/6.037/sicp.pdf"
status: "Finished"
---

**Question**: Louis Reasoner rewrites `expmod` using explicit multiplication instead of `square`:

```scheme
(define (expmod base exp m)
  (cond ((= exp 0) 1)
        ((even? exp)
         (remainder (* (expmod base (/ exp 2) m)
                       (expmod base (/ exp 2) m))
                    m))
        ...))
```

Eva says this transforms the `Θ(log n)` process into `Θ(n)`. Explain.

**Answer**:

The original uses `(square (expmod ...))` — a single recursive call. The new version calls `(expmod base (/ exp 2) m)` *twice*, creating a tree-shaped process instead of a linear chain.

- Original: a linear chain of `Θ(log n)` calls.
- New version: a binary tree. Each even-exponent step spawns 2 children instead of 1.

The tree has height `Θ(log n)`. Because at least half of the levels split into two branches, the total nodes are `Ω(2^(log n / 2)) = Ω(√n)`. More precisely, the total nodes are `Θ(n)`, since the tree at each level doubles when `exp` is even, exactly cancelling the halving.

Result: `Θ(log n)` becomes `Θ(n)`.
