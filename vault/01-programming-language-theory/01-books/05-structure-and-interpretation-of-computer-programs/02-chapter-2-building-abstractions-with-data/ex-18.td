---
_type: PltBook
_label: 'Exercise 2.18: Reverse a list'
parent: fref("/01-programming-language-theory/01-books/05-structure-and-interpretation-of-computer-programs/02-chapter-2-building-abstractions-with-data/index.td")
journey: fref("/01-programming-language-theory/index.td")
url: "https://web.mit.edu/6.001/6.037/sicp.pdf"
status: "Finished"
---

**Question**: Define `reverse` that returns a list with elements in reverse order.

**Answer**: Use an iterative approach with an accumulator:

```scheme
(define (reverse l)
  (define (reverse-iter l result)
    (if (null? l)
      result
      (reverse-iter (cdr l) (cons (car l) result))))
  (reverse-iter l null))
```
