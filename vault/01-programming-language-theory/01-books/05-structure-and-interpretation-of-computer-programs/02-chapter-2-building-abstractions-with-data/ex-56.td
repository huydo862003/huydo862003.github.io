---
_type: PltBook
_label: 'Exercise 2.56: Symbolic differentiation with exponentiation'
parent: fref("/01-programming-language-theory/01-books/05-structure-and-interpretation-of-computer-programs/02-chapter-2-building-abstractions-with-data/index.td")
journey: fref("/01-programming-language-theory/index.td")
url: "https://web.mit.edu/6.001/6.037/sicp.pdf"
status: "Finished"
---

**Question**: Extend the symbolic differentiator to handle exponentiation using the rule:

$$\frac{d(u^n)}{dx} = nu^{n-1}\frac{du}{dx}$$

**Answer**: Add a new clause to `deriv` with constructors/selectors for exponentiation expressions using `**`.

```scheme
(define (exponentiation? exp)
  (and (pair? exp) (eq? (car exp) '**)))

(define (make-exponentiation b n)
  (cond ((= n 0) 1)
        ((= n 1) b)
        (else (list '** b n))))

(define (base exp) (cadr exp))
(define (exponent exp) (caddr exp))
```

New `deriv` clause:
```scheme
((exponentiation? expr)
 (make-product
   (make-product
     (exponent expr)
     (make-exponentiation (base expr) (- (exponent expr) 1)))
   (deriv (base expr) var)))
```
