---
_type: PltBook
_label: 'Exercise 1.32'
parent: fref("/01-programming-language-theory/01-books/05-structure-and-interpretation-of-computer-programs/01-chapter-1-building-abstractions-with-procedures/index.td")
journey: fref("/01-programming-language-theory/index.td")
url: "https://web.mit.edu/6.001/6.037/sicp.pdf"
status: "Finished"
---

**Question**: a. Show that `sum` and `product` (Exercise 1.31) are both special cases of a still more general notion called `accumulate` that combines a collection of terms, using some general accumulation function:

```scheme
(accumulate combiner null-value term a next b)
```

`accumulate` takes as arguments the same term and range specifications as `sum` and `product`, together with a `combiner` procedure (of two arguments) that specifies how the current term is to be combined with the accumulation of the preceding terms and a `null-value` that specifies what base value to use when the terms run out.

Write `accumulate` and show how `sum` and `product` can both be defined as simple calls to accumulate.

b. If your `accumulate` procedure generates a recursive process, write one that generates an iterative process. If it generates an iterative process, write one that generates a recursive process.

