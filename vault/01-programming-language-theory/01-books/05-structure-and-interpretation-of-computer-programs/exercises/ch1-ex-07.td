---
_type: PltBook
_label: 'Exercise 1.7: Improved good-enough? for sqrt'
parent: fref("/01-programming-language-theory/01-books/05-structure-and-interpretation-of-computer-programs/01-chapter-1-building-abstractions-with-procedures.td")
journey: fref("/01-programming-language-theory/index.td")
url: "https://web.mit.edu/6.001/6.037/sicp.pdf"
status: "Finished"
---

**Question**: The `good-enough?` test based on a fixed tolerance `0.001` fails for very small and very large numbers. Design an alternative that watches how `guess` changes from one iteration to the next and stops when the change is a very small *fraction* of the guess.

**Answer**: The original test `(< (abs (- (* guess guess) x)) 0.001)` fails because:
- For very small numbers (e.g. `0.0001`), the tolerance is larger than the number itself.
- For very large numbers, floating-point precision limits mean the test may never be satisfied.

Alternative: stop when the relative change in `guess` is small.

```scheme
(define (sqrt x)
  (define (sqrt-iter guess)
    (define next-guess (improve guess))
    (if (close-enough? guess next-guess)
      guess
      (sqrt-iter next-guess)))
  (define (close-enough? guess next-guess)
    (< (abs (- guess next-guess)) (/ guess 1000)))
  (define (improve guess)
    (/ (+ guess (/ x guess)) 2.0))
  (sqrt-iter 1))
```
