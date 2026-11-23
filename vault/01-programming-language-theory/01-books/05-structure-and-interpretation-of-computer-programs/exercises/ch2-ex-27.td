---
_type: PltBook
_label: 'Exercise 2.27: Deep reverse'
parent: fref("/01-programming-language-theory/01-books/05-structure-and-interpretation-of-computer-programs/02-chapter-2-building-abstractions-with-data.td")
journey: fref("/01-programming-language-theory/index.td")
url: "https://web.mit.edu/6.001/6.037/sicp.pdf"
status: "Finished"
---

**Question**: Write `deep-reverse` that reverses a list and all sublists recursively.

```scheme
(define x (list (list 1 2) (list 3 4)))
(deep-reverse x) ; => ((4 3) (2 1))
```

**Answer**:

```scheme
(define (deep-reverse l)
  (define (reverse-iter l result)
    (if (null? l)
      result
      (let ((cur-e (if (pair? (car l))
                     (deep-reverse (car l))
                     (car l))))
        (reverse-iter (cdr l) (cons cur-e result)))))
  (reverse-iter l null))
```
