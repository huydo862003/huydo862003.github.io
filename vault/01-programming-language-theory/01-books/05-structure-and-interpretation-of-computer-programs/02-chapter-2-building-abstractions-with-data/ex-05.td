---
_type: PltBook
_label: 'Exercise 2.5: Pairs as integers (2^a * 3^b)'
parent: fref("/01-programming-language-theory/01-books/05-structure-and-interpretation-of-computer-programs/02-chapter-2-building-abstractions-with-data/index.td")
journey: fref("/01-programming-language-theory/index.td")
url: "https://web.mit.edu/6.001/6.037/sicp.pdf"
status: "Finished"
---

**Question**: Represent pairs of nonnegative integers as the integer $2^a 3^b$. Define `cons`, `car`, and `cdr`.

**Answer**: To extract `a`, count how many times 2 divides the product. To extract `b`, count how many times 3 divides it.

```scheme
(define (cons x y)
  (* (expt 2 x)
     (expt 3 y)))

(define (car z)
  (define (car-iter z result)
    (if (= (remainder z 2) 1)
      result
      (car-iter (/ z 2) (+ result 1))))
  (car-iter z 0))

(define (cdr z)
  (define (cdr-iter z result)
    (if (= (remainder z 3) 1)
      result
      (cdr-iter (/ z 3) (+ result 1))))
  (cdr-iter z 0))
```
