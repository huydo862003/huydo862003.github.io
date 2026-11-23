---
_type: PltBook
_label: 'Exercise 1.42: Function composition'
parent: fref("/01-programming-language-theory/01-books/05-structure-and-interpretation-of-computer-programs/01-chapter-1-building-abstractions-with-procedures.td")
journey: fref("/01-programming-language-theory/index.td")
url: "https://web.mit.edu/6.001/6.037/sicp.pdf"
status: "Finished"
---

**Question**: Define `compose` such that `((compose f g) x) = f(g(x))`.

**Answer**:

```scheme
(define (compose f g)
  (lambda (x) (f (g x))))
```

Example: `((compose square inc) 6)` → `(square (inc 6))` → `(square 7)` → `49`.
