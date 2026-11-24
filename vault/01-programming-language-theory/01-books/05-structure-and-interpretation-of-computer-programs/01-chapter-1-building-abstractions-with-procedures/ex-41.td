---
_type: PltBook
_label: 'Exercise 1.41: Double procedure application'
parent: fref("/01-programming-language-theory/01-books/05-structure-and-interpretation-of-computer-programs/01-chapter-1-building-abstractions-with-procedures/index.td")
journey: fref("/01-programming-language-theory/index.td")
url: "https://web.mit.edu/6.001/6.037/sicp.pdf"
status: "Finished"
---

**Question**: Define `double` that applies a procedure twice. What is `(((double (double double)) inc) 5)`?

**Answer**:

```scheme
(define (double f)
  (lambda (x) (f (f x))))
```

The result is **21**. Working it out:

- `(double double)` → function `f` where `(f x) = (double (double x))`.
- `(double f)` → function `g` where `(g x) = (f (f x))`.
- `(g inc)` = `(f (f inc))` = `(f (double (double inc)))` = `(f (double inc-2))` = `(f inc-4)` = `(double (double inc-4))` = `(double inc-8)` = `inc-16`.
- `(inc-16 5)` = `21`.
