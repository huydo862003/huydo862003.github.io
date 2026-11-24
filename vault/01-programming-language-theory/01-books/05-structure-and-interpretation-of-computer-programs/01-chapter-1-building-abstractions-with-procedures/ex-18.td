---
_type: PltBook
_label: 'Exercise 1.18: Logarithmic multiplication (iterative)'
parent: fref("/01-programming-language-theory/01-books/05-structure-and-interpretation-of-computer-programs/01-chapter-1-building-abstractions-with-procedures/index.td")
journey: fref("/01-programming-language-theory/index.td")
url: "https://web.mit.edu/6.001/6.037/sicp.pdf"
status: "Finished"
---

**Question**: Using the results of Exercises 1.16 and 1.17, devise a procedure that generates an *iterative* process for multiplying two integers using `double`, `halve`, and `add`, in a logarithmic number of steps.

**Answer**: Invariant: `s + a * b = result`. Initially `s = 0`.

- If `b` is even: `s + (2a) * (b/2) = result` → `a ← 2a`, `b ← b/2`.
- If `b` is odd: `(s+a) + (2a) * ((b-1)/2) = result` → `s ← s+a`, `a ← 2a`, `b ← (b-1)/2`.

```scheme
(define (double x) (* x 2))
(define (halve x)
  (if (= (remainder x 2) 0)
    (/ x 2)
    (/ (- x 1) 2)))

(define (mul a b)
  (define (even? k)
    (= (double (halve k)) k))
  (define (mul-iter s a b)          ; invariant: s + a * b = result
    (cond ((= b 0) s)
          ((even? b) (mul-iter s (double a) (halve b)))
          (else (mul-iter (+ s a) (double a) (halve (+ b -1))))))
  (mul-iter 0 a b))
```
