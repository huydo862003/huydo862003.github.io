---
_type: Flashcard
deck: 'pure-lambda-calculus'
concepts:
  - fref("programming-language-theory/concepts/fixed-point-combinator.td")
books:
  - fref("programming-language-theory/books/types-and-programming-languages/chapter-5-the-untyped-pure-lambda-calculus.td")
---

::: flashcard
What is the definition of the fixed-point combinator?
=== key
A fixed-point combinator is a function that finds the fixed-point of any given function regarding the Evaluation/Reduction relation.

That is, given $\text{fix}$ as a fixed-point combinator and $f$ as any arbitrary function, we have:

$$
\text{fix}\ f \to^* f\ (\text{fix}\ f)
$$
:::
