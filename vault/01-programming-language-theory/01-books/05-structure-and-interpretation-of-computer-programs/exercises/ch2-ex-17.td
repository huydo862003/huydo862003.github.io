---
_type: PltBook
_label: 'Exercise 2.17: Last pair of a list'
parent: fref("/01-programming-language-theory/01-books/05-structure-and-interpretation-of-computer-programs/02-chapter-2-building-abstractions-with-data.td")
journey: fref("/01-programming-language-theory/index.td")
url: "https://web.mit.edu/6.001/6.037/sicp.pdf"
status: "Finished"
---

**Question**: Define `last-pair` that returns the list containing only the last element of a given nonempty list.

**Answer**:

```scheme
(define (last-pair l)
  (cond ((null? l) (error "`last-pair` cannot be called on an empty list"))
        ((null? (cdr l)) l)
        (else (last-pair (cdr l)))))
```
