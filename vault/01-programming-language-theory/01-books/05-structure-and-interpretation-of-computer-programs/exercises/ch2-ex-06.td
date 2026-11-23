---
_type: PltBook
_label: 'Exercise 2.6: Church numerals'
parent: fref("/01-programming-language-theory/01-books/05-structure-and-interpretation-of-computer-programs/02-chapter-2-building-abstractions-with-data.td")
journey: fref("/01-programming-language-theory/index.td")
url: "https://web.mit.edu/6.001/6.037/sicp.pdf"
status: "Finished"
---

**Question**: Given `zero` and `add-1` as Church numerals, define `one` and `two` directly, and give a direct definition of `+`.

```scheme
(define zero (lambda (f) (lambda (x) x)))
(define (add-1 n)
  (lambda (f) (lambda (x) (f ((n f) x)))))
```

**Answer**: The number `n` is represented as the function that applies `f` exactly `n` times to `x`.

`one` (via substitution on `(add-1 zero)`):
```scheme
(lambda (f) (lambda (x) (f x)))
```

`two`:
```scheme
(lambda (f) (lambda (x) (f (f x))))
```

Direct definition of `+` (apply `f` `m` times to `x`, then `n` more times):
```scheme
(define (+ n m)
  (lambda (f) (lambda (x) ((n f) ((m f) x)))))
```
