---
createdAt: "2026-03-28"
updatedAt: "2026-03-28"
question: How to encode booleans and conditionals using Church booleans in lambda calculus?
answer: TODO
deck: pure-lambda-calculus
concepts:
  - pure-untyped-lambda-calculus
books:
  - chapter-5-the-untyped-pure-lambda-calculus
tags:
  - "pure untyped lambda calculus"
  - "lambda"
  - "text"
  - "aligned"
  - "booleans"
  - "begin"
  - "tru"
---


Booleans:

$$
\begin{aligned}
\text{tru} & = \lambda f.\ \lambda s.\ f \\
\text{fls} & = \lambda f.\ \lambda s.\ s \\
\end{aligned}
$$

Conditionals (call-by-name):

$$
\text{test} = \lambda c.\ \lambda t.\ \lambda e.\ c\ t\ e
$$
