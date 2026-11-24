---
_type: PltBook
_label: 'Exercise 2.48: Directed line segments as vector pairs'
parent: fref("/01-programming-language-theory/01-books/05-structure-and-interpretation-of-computer-programs/02-chapter-2-building-abstractions-with-data/index.td")
journey: fref("/01-programming-language-theory/index.td")
url: "https://web.mit.edu/6.001/6.037/sicp.pdf"
status: "Finished"
---

**Question**: Using vectors from Exercise 2.46, define `make-segment`, `start-segment`, and `end-segment` for directed line segments.

**Answer**:

```scheme
(define (make-segment v1 v2) (cons v1 v2))
(define (start-segment v) (car v))
(define (end-segment v) (cdr v))
```
