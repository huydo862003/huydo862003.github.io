---
_type: PltFlashcard
_label: 'SICP: What is the closure property of data?'
concepts:
  - fref("/01-programming-language-theory/02-concepts/closure.td")
books:
  - fref("/01-programming-language-theory/01-books/05-structure-and-interpretation-of-computer-programs/02-chapter-2-building-abstractions-with-data/index.td")
tags:
  - 'programming language basic'
---

::: flashcard{deck="08-Language Theory"}
What is the closure property of a data combination operation? Why is it important?
=== key
*Closure property*: A data combination operation satisfies the closure property if the result of combining elements can itself be combined using the same operation.

For example, `cons` satisfies the closure property because a pair can be constructed from elements which are themselves pairs:

```scheme
(cons (cons 1 2) (cons 3 4))
```

Importance: Closure permits creating *hierarchical* structures - structures made of parts, which are made up of parts, and so on. Without closure, we would be limited to flat combinations. This is what makes lists and trees possible.

Note: This is a mathematical property of an operation, different from the programming language notion of a "closure" (a function that captures its lexical environment).
:::
