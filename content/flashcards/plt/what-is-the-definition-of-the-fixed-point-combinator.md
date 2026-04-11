---
createdAt: "2026-03-28"
updatedAt: "2026-03-28"
question: What is the definition of the fixed-point combinator?
answer: TODO
deck: pure-lambda-calculus
concepts:
  - fixed-point-combinator
books:
  - chapter-5-the-untyped-pure-lambda-calculus
tags: []
keywords:
  - "fixed point combinator"
  - "fixed-point"
  - "function"
  - "text"
  - "fix"
  - "combinator"
  - "finds"
---


A fixed-point combinator is a function that finds the fixed-point of any given function regarding the Evaluation/Reduction relation.

That is, given $\text{fix}$ as a fixed-point combinator and $f$ as any arbitrary function, we have:

$$
\text{fix}\ f \to^* f\ (\text{fix}\ f)
$$
