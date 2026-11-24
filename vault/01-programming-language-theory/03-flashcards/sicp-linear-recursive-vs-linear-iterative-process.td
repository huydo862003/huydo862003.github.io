---
_type: PltFlashcard
_label: 'SICP: Linear recursive vs linear iterative process'
deck: 'language theory'
books:
  - fref("/01-programming-language-theory/01-books/05-structure-and-interpretation-of-computer-programs/01-chapter-1-building-abstractions-with-procedures/index.td")
tags:
  - 'programming language basic'
---

::: flashcard
What is the difference between a linear recursive process and a linear iterative process? Can a recursive procedure generate an iterative process?
=== key
- *Linear recursive process*: Grows by building up a chain of deferred operations (expansion) and then contracting as operations are performed. The interpreter must keep track of hidden information proportional to `n`. Shape: expand then contract.

- *Linear iterative process*: Does not grow or shrink. Its state can be fully described by a fixed number of state variables. The number of steps is proportional to `n` but constant space.

Yes, a recursive procedure can generate an iterative process. In Scheme (which is tail-recursive), a procedure described recursively that calls itself in tail position executes in constant space. This is called *tail recursion*. Special iteration constructs (loops) can be considered syntactic sugar in a tail-recursive implementation.
:::
