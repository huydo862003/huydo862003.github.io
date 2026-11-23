---
_type: PltBook
_label: "Exercise 1.29: Simpson's Rule for numerical integration"
parent: fref("/01-programming-language-theory/01-books/05-structure-and-interpretation-of-computer-programs/01-chapter-1-building-abstractions-with-procedures.td")
journey: fref("/01-programming-language-theory/index.td")
url: "https://web.mit.edu/6.001/6.037/sicp.pdf"
status: "Finished"
---

**Question**: Implement numerical integration using Simpson's Rule:

$$\frac{h}{3}(y_0 + 4y_1 + 2y_2 + 4y_3 + \cdots + 4y_{n-1} + y_n)$$

where $h = (b-a)/n$. Compare accuracy with the basic integral procedure.

**Answer**:

```scheme
(define (integral f a b n)
  (define step-size (/ (- b a) (* n 1.0)))
  (define (next-coefficient k)
    (cond ((= k 4) 2)
          ((= k 2) 4)))
  (define (integral-iter c k)
    (if (>= c b)
      0
      (+ (* k (f c))
         (integral-iter (+ c step-size) (next-coefficient k)))))
  (* (/ step-size 3.0)
     (+ (f a)
        (integral-iter (+ a step-size) 4)
        (f b))))
```

Simpson's Rule converges much faster: integrating `cube` from 0 to 1 gives `0.25` exactly even at `n=100`, while the basic method gives only `0.245` at comparable precision.
