---
_type: PltBook
_label: 'Exercise 2.20: Same-parity filter (dotted-tail notation)'
parent: fref("/01-programming-language-theory/01-books/05-structure-and-interpretation-of-computer-programs/02-chapter-2-building-abstractions-with-data.td")
journey: fref("/01-programming-language-theory/index.td")
url: "https://web.mit.edu/6.001/6.037/sicp.pdf"
status: "Finished"
---

**Question**: Using dotted-tail notation, write `same-parity` that returns a list of all arguments with the same even/odd parity as the first argument.

**Answer**:

```scheme
(define (same-parity . l)
  (define (same-parity-iter l p)
    (cond ((null? l) '())
          ((= (remainder (car l) 2) p)
           (cons (car l) (same-parity-iter (cdr l) p)))
          (else (same-parity-iter (cdr l) p))))
  (if (null? l)
    '()
    (cons (car l)
          (same-parity-iter (cdr l) (remainder (car l) 2)))))
```

Dotted-tail notation `(define (f . args))` collects all arguments into a list.
