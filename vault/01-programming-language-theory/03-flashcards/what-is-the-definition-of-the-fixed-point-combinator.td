---
_type: PltFlashcard
_label: 'What is the definition of the fixed-point combinator?'
concepts:
  - fref("/01-programming-language-theory/02-concepts/fixed-point-combinator.td")
books:
  - fref("/01-programming-language-theory/01-books/01-types-and-programming-languages/03-part-i-untyped-systems/03-chapter-5-the-untyped-pure-lambda-calculus.td")
tags:
  - 'pure lambda calculus'
---

::: flashcard{deck="12-Pure Lambda Calculus"}
What is the definition of the fixed-point combinator?
=== key
A fixed-point combinator is a function that finds the fixed-point of any given function regarding the Evaluation/Reduction relation.

That is, given $\text{fix}$ as a fixed-point combinator and $f$ as any arbitrary function, we have:

$$
\text{fix}\ f \to^* f\ (\text{fix}\ f)
$$
:::
