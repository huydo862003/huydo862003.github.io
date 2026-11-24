---
_type: PltBook
_label: 'Exercise 2.57'
parent: fref("/01-programming-language-theory/01-books/05-structure-and-interpretation-of-computer-programs/02-chapter-2-building-abstractions-with-data/index.td")
journey: fref("/01-programming-language-theory/index.td")
url: "https://web.mit.edu/6.001/6.037/sicp.pdf"
status: "Finished"
---

**Question**: Extend the differentiation program to handle sums and products of arbitrary numbers of (two or more) terms. Then the last example above could be expressed as
```scheme
(deriv '(* x y (+ x 3)) 'x)
```
Try to do this by changing only the representation for sums and products, without changing the deriv procedure at all. For example, the addend of a sum would be the first term, and the augend would be the sum of the rest of the terms

