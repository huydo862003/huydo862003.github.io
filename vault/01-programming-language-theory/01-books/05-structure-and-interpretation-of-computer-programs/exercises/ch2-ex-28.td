---
_type: PltBook
_label: 'Exercise 2.28: Fringe of a tree'
parent: fref("/01-programming-language-theory/01-books/05-structure-and-interpretation-of-computer-programs/02-chapter-2-building-abstractions-with-data.td")
journey: fref("/01-programming-language-theory/index.td")
url: "https://web.mit.edu/6.001/6.037/sicp.pdf"
status: "Finished"
---

**Question**: Write `fringe` that returns a list of all leaves of a tree in left-to-right order.

```scheme
(define x (list (list 1 2) (list 3 4)))
(fringe x)       ; => (1 2 3 4)
(fringe (list x x)) ; => (1 2 3 4 1 2 3 4)
```

**Answer**: Build from right to left using an accumulator:

```scheme
(define (fringe t)
  (define (fringe-iter t right-part)
    (if (null? t)
      right-part
      (let ((new-right-part (fringe-iter (cdr t) right-part))
            (cur-e (car t)))
        (if (pair? cur-e)
          (fringe-iter cur-e new-right-part)
          (cons cur-e new-right-part)))))
  (fringe-iter t null))
```
