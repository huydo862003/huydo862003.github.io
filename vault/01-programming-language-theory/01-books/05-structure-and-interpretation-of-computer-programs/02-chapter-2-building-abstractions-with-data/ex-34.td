---
_type: PltBook
_label: 'Exercise 2.34'
parent: fref("/01-programming-language-theory/01-books/05-structure-and-interpretation-of-computer-programs/02-chapter-2-building-abstractions-with-data/index.td")
journey: fref("/01-programming-language-theory/index.td")
url: "https://web.mit.edu/6.001/6.037/sicp.pdf"
status: "Finished"
---

**Question**: Evaluating a polynomial in `x` at a given value of `x` can be formulated as an accumulation. We evaluate the polynomial

$$
  a_nx^n + a_{n-1}x^{n-1}+\cdots+a_1x + a_0
$$

using a well-known algorithm called Horner's rule, which structures the computation as

$$
  (\cdots(a_nx+a_{n-1})x + \cdots + a_1)x + a_0
$$

In other words, we start with $a_n$, multiply by $x$, add $a_{n-1}$, multiply by `x`, and so on, until we reach $a_0$.

Fill in the following template to produce a procedure that evaluates a polynomial using Horner's rule. Assume that the coefficients of the polynomial are arranged in a sequence from $a_0$ through $a_n$.

```scheme
(define (horner-eval x coefficient-sequence)
  (accumulate (lambda (this-coeff higher-terms) <??>)
              0
              coefficient-sequence))
```

For example, to compute $1+3x+5x^3+x^5$ at x = 2 you would evaluate

$$
(horner-eval 2 (list 1 3 0 5 0 1))
$$

