---
_type: PltBook
_label: 'Exercise 2.47: Frame selectors'
parent: fref("/01-programming-language-theory/01-books/05-structure-and-interpretation-of-computer-programs/02-chapter-2-building-abstractions-with-data.td")
journey: fref("/01-programming-language-theory/index.td")
url: "https://web.mit.edu/6.001/6.037/sicp.pdf"
status: "Finished"
---

**Question**: Supply appropriate selectors for each of these two frame constructors:

```scheme
(define (make-frame origin edge1 edge2) (list origin edge1 edge2))
(define (make-frame origin edge1 edge2) (cons origin (cons edge1 edge2)))
```

**Answer**:

For the `list` version:
```scheme
(define (origin-frame f) (car f))
(define (edge1-frame f) (cadr f))
(define (edge2-frame f) (caddr f))
```

For the `cons` version:
```scheme
(define (origin-frame f) (car f))
(define (edge1-frame f) (cadr f))
(define (edge2-frame f) (cddr f))   ; cdr of cdr, not car of cdr of cdr
```

The only difference is `edge2-frame`: `(caddr f)` vs `(cddr f)`.
