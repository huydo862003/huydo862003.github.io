---
_type: PltBook
_label: 'Exercise 1.37: Continued fractions'
parent: fref("/01-programming-language-theory/01-books/05-structure-and-interpretation-of-computer-programs/01-chapter-1-building-abstractions-with-procedures/index.td")
journey: fref("/01-programming-language-theory/index.td")
url: "https://web.mit.edu/6.001/6.037/sicp.pdf"
status: "Finished"
---

**Question**: Define `cont-frac` to compute k-term finite continued fractions. How large must `k` be to approximate `1/φ` to 4 decimal places? Write both recursive and iterative versions.

$$f = \cfrac{N_1}{D_1 + \cfrac{N_2}{D_2 + \cfrac{N_3}{D_3 + \cdots}}}$$

**Answer**: Minimum `k` for 4 decimal places: **11**.

```
> (cont-frac (lambda (x) 1.0) (lambda (x) 1.0) 11)
0.6180555555555556
```

Recursive version (builds from outside in):

```scheme
(define (cont-frac n d k)
  (define (cont-frac-iter i)  ; 1-based
    (if (> i k)
      0
      (/ (n i)
         (+ (d i)
            (cont-frac-iter (+ i 1))))))
  (cont-frac-iter 1))
```

Iterative version (builds from inside out):

```scheme
(define (cont-frac n d k)
  (define (cont-frac-iter i result)  ; 1-based
    (if (<= i 0)
      result
      (cont-frac-iter (- i 1)
                      (/ (n i)
                         (+ (d i) result)))))
  (cont-frac-iter k 0))
```
