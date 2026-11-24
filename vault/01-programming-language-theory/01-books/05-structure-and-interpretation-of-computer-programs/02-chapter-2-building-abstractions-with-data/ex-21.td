---
_type: PltBook
_label: 'Exercise 2.21'
parent: fref("/01-programming-language-theory/01-books/05-structure-and-interpretation-of-computer-programs/02-chapter-2-building-abstractions-with-data/index.td")
journey: fref("/01-programming-language-theory/index.td")
url: "https://web.mit.edu/6.001/6.037/sicp.pdf"
status: "Finished"
---

**Question**: The procedure `square-list` takes a list of numbers as argument and returns a list of the squares of those numbers.

```scheme
(square-list (list 1 2 3 4))
(1 4 9 16)
```

Here are two different definitions of `square-list`. Complete both of them by filling in the missing expressions:

```scheme
(define (square-list items)
  (if (null? items)
    nil
    (cons ⟨??⟩ ⟨??⟩)))
(define (square-list items)
  (map ⟨??⟩ ⟨??⟩))
```

