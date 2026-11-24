---
_type: PltBook
_label: 'Exercise 3.2'
parent: fref("/01-programming-language-theory/01-books/05-structure-and-interpretation-of-computer-programs/03-chapter-3-modularity-objects-and-state/index.td")
journey: fref("/01-programming-language-theory/index.td")
url: "https://web.mit.edu/6.001/6.037/sicp.pdf"
status: "Finished"
---

**Question**: In software-testing applications, it is useful to be able to count the number of times a given procedure is called during the course of a computation. Write a procedure make-monitored that takes as input a procedure, `f`, that itself takes one input. The result returned by `make-monitored` is a third procedure, say `mf`, that keeps track of the number of times it has been called by maintaining an internal counter. If the input to `mf` is the special symbol `how-many-calls?`, then `mf` returns the value of the counter.
If the input is the special symbol `reset-count`, then `mf` resets the counter to zero.
 For any other input, `mf` returns the result of calling `f` on that input and increments the counter. For instance, we could make a monitored version of the `sqrt` procedure:

```scheme
(define s (make-monitored sqrt))
(s 100)
10
(s 'how-many-calls?)
1
```

