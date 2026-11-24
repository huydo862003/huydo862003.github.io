---
_type: PltBook
_label: 'Exercise 3.1'
parent: fref("/01-programming-language-theory/01-books/05-structure-and-interpretation-of-computer-programs/03-chapter-3-modularity-objects-and-state/index.td")
journey: fref("/01-programming-language-theory/index.td")
url: "https://web.mit.edu/6.001/6.037/sicp.pdf"
status: "Finished"
---

**Question**: An accumulator is a procedure that is called repeatedly with a single numeric argument and accumulates its arguments into a sum. Each time it is called, it returns the currently accumulated sum. Write a procedure `make-accumulator` that generates accumulators, each maintaining an independent sum. The input to `make-accumulator` should specify the initial value of the sum; for example

```scheme
(define A (make-accumulator 5))
(A 10)
15
(A 10)
25
```

