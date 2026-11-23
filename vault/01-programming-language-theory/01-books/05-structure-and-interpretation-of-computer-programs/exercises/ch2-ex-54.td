---
_type: PltBook
_label: 'Exercise 2.54: Recursive equal?'
parent: fref("/01-programming-language-theory/01-books/05-structure-and-interpretation-of-computer-programs/02-chapter-2-building-abstractions-with-data.td")
journey: fref("/01-programming-language-theory/index.td")
url: "https://web.mit.edu/6.001/6.037/sicp.pdf"
status: "Finished"
---

**Question**: Implement `equal?` recursively using `eq?` for symbols.

**Answer**: Two lists are `equal?` if they have the same elements in the same order. Base cases: both null (true), one null (false), `car`s are `eq?` and `cdr`s are `equal?`.

```scheme
(define (equal? l1 l2)
  (cond ((and (null? l1) (null? l2)) #t)
        ((or (null? l1) (null? l2)) #f)
        ((eq? (car l1) (car l2)) (equal? (cdr l1) (cdr l2)))
        (else #f)))
```
