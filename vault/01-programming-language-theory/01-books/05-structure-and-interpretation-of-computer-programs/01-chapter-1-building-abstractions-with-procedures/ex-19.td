---
_type: PltBook
_label: 'Exercise 1.19: Logarithmic Fibonacci'
parent: fref("/01-programming-language-theory/01-books/05-structure-and-interpretation-of-computer-programs/01-chapter-1-building-abstractions-with-procedures/index.td")
journey: fref("/01-programming-language-theory/index.td")
url: "https://web.mit.edu/6.001/6.037/sicp.pdf"
status: "Finished"
---

**Question**: Using the transformation $T_{pq}$ that maps $(a, b) \to (bq + aq + ap, bp + aq)$, show that applying it twice equals a single $T_{p'q'}$ and find $p'$ and $q'$. Use this to compute Fibonacci numbers in $\Theta(\log n)$ steps.

**Answer**:

Computing $T^2_{pq}$:

$$T_{pq}^2(a, b) = T_{pq}(bq + aq + ap, bp + aq)$$

Working through the algebra:

$$p' = p^2 + q^2, \quad q' = 2pq + q^2$$

The iterative procedure:

```scheme
(define (fib n)
  (fib-iter 1 0 0 1 n))
(define (fib-iter a b p q count)
  (cond ((= count 0) b)
        ((even? count)
         (fib-iter a
                   b
                   (+ (* p p) (* q q))       ; p'
                   (+ (* 2 p q) (* q q))     ; q'
                   (/ count 2)))
        (else (fib-iter (+ (* b q) (* a q) (* a p))
                        (+ (* b p) (* a q))
                        p
                        q
                        (- count 1)))))
```
