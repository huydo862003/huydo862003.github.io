---
_type: PltBook
_label: 'Exercise 2.2: Midpoint of a line segment'
parent: fref("/01-programming-language-theory/01-books/05-structure-and-interpretation-of-computer-programs/02-chapter-2-building-abstractions-with-data/index.td")
journey: fref("/01-programming-language-theory/index.td")
url: "https://web.mit.edu/6.001/6.037/sicp.pdf"
status: "Finished"
---

**Question**: Define constructors and selectors for points and line segments, then implement `midpoint-segment`.

**Answer**:

```scheme
(define (make-point x y)
  (cons x y))

(define (x-point p) (car p))
(define (y-point p) (cdr p))

(define (make-segment s e)
  (cons s e))

(define (start-segment s) (car s))
(define (end-segment s) (cdr s))

(define (midpoint-segment s)
  (let ((start-point (start-segment s))
        (end-point (end-segment s)))
    (make-point (average (x-point start-point) (x-point end-point))
                (average (y-point start-point) (y-point end-point)))))
```
