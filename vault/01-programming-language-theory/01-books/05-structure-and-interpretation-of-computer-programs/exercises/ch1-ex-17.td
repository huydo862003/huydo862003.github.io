---
_type: PltBook
_label: 'Exercise 1.17: Logarithmic multiplication (recursive)'
parent: fref("/01-programming-language-theory/01-books/05-structure-and-interpretation-of-computer-programs/01-chapter-1-building-abstractions-with-procedures.td")
journey: fref("/01-programming-language-theory/index.td")
url: "https://web.mit.edu/6.001/6.037/sicp.pdf"
status: "Finished"
---

**Question**: Using `double` and `halve`, design a multiplication procedure analogous to `fast-expt` that uses a logarithmic number of steps.

**Answer**: Analogous to fast exponentiation:
- `a * b = (a * (b/2)) * 2` if `b` is even
- `a * b = a + a * ((b-1)/2) * 2` if `b` is odd

```scheme
(define (double x) (* x 2))
(define (halve x)
  (if (= (remainder x 2) 0)
    (/ x 2)
    (/ (- x 1) 2)))

(define (mul a b)
  (define (even? k)
    (= (double (halve k)) k))
  (define (mul-iter n)
    (cond ((= n 0) 0)
          ((even? n) (double (mul-iter (halve n))))
          (else (+ a (double (mul-iter (halve (+ n -1))))))))
  (mul-iter b))
```
