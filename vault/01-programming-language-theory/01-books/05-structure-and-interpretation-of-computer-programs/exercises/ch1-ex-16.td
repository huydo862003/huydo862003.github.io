---
_type: PltBook
_label: 'Exercise 1.16: Iterative fast exponentiation using invariants'
parent: fref("/01-programming-language-theory/01-books/05-structure-and-interpretation-of-computer-programs/01-chapter-1-building-abstractions-with-procedures.td")
journey: fref("/01-programming-language-theory/index.td")
url: "https://web.mit.edu/6.001/6.037/sicp.pdf"
status: "Finished"
---

**Question**: Design an iterative exponentiation process that uses successive squaring and a logarithmic number of steps. Hint: maintain a state variable `a` such that `a*b^n` is invariant across iterations.

**Answer**: The invariant is `a * b^n = result`. Initially `a = 1`.

- If `n` is even: `a*(b^2)^(n/2) = result` → `b ← b²`, `n ← n/2`, `a` unchanged.
- If `n` is odd: `(a*b)*(b^2)^((n-1)/2) = result` → `a ← a*b`, `b ← b²`, `n ← (n-1)/2`.

This technique of identifying an invariant is a general strategy for designing iterative algorithms.

```scheme
(define (expt b n)
  (define (even? k)
    (= (remainder k 2) 0))
  (define (square k)
    (* k k))
  (define (expt-iter n b a)                         ; a*b^n = result
    (cond ((= n 0) a)                               ; a = result
          ((even? n) (expt-iter (/ n 2)             ; a*(b^2)^(n/2) = result
                                (square b)
                                a))
          (else (expt-iter (/ (- n 1) 2)            ; (a*b)*(b^2)^((n-1)/2) = result
                           (square b)
                           (* a b)))))
  (expt-iter n b 1))
```
