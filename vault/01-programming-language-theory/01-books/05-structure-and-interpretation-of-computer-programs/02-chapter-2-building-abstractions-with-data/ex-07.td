---
_type: PltBook
_label: 'Exercise 2.7: Interval arithmetic selectors'
parent: fref("/01-programming-language-theory/01-books/05-structure-and-interpretation-of-computer-programs/02-chapter-2-building-abstractions-with-data/index.td")
journey: fref("/01-programming-language-theory/index.td")
url: "https://web.mit.edu/6.001/6.037/sicp.pdf"
status: "Finished"
---

**Question**: Given `(define (make-interval a b) (cons a b))`, define `upper-bound` and `lower-bound`.

**Answer**:

```scheme
(define (lower-bound i) (car i))
(define (upper-bound i) (cdr i))
```
