---
_type: PltBook
_label: 'Exercise 2.14'
parent: fref("/01-programming-language-theory/01-books/05-structure-and-interpretation-of-computer-programs/02-chapter-2-building-abstractions-with-data/index.td")
journey: fref("/01-programming-language-theory/index.td")
url: "https://web.mit.edu/6.001/6.037/sicp.pdf"
status: "Finished"
---

**Question**: Aer considerable work, Alyssa P. Hacker delivers her fin- ished system. Several years later, aer she has forgotten all about it, she gets a frenzied call from an irate user, Lem E. Tweakit. It seems that Lem has noticed that the formula for parallel resistors can be wrien in two algebraically equivalent ways:

$$
    \frac{R_1R_2}{R1 + R2}
$$
and

$$
    \frac{1}{\frac{1}{R_1} + \frac{1}{R_2}}
$$

He has written the following two programs, each of which computes the parallel-resistors formula differently:

```scheme
(define (par1 r1 r2)
  (div-interval (mul-interval r1 r2)
                (add-interval r1 r2)))
(define (par2 r1 r2)
  (let ((one (make-interval 1 1)))
    (div-interval
    one (add-interval (div-interval one r1)
        (div-interval one r2)))))
```

Lem complains that Alyssa’s program gives different answers for the two ways of computing. This is a serious complaint.

Demonstrate that Lem is right. Investigate the behavior of the system on a variety of arithmetic expressions. Make some intervals A and B, and use them in computing the expressions A/A and A/B. You will get the most insight by using intervals whose width is a small percentage of the center value. Examine the results of the computation in center-percent form (see Exercise 2.12).

