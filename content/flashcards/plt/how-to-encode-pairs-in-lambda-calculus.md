---
createdAt: "2026-03-28"
updatedAt: "2026-03-28"
question: How to encode pairs in lambda calculus?
answer: TODO
deck: pure-lambda-calculus
concepts:
  - pure-untyped-lambda-calculus
books:
  - chapter-5-the-untyped-pure-lambda-calculus
tags:
  - "pure untyped lambda calculus"
  - "text"
  - "lambda"
  - "aligned"
  - "begin"
  - "pair"
  - "fst"
---


$$
\begin{aligned}
\text{pair} & = \lambda f.\ \lambda s. \ \lambda o.\ o\ f\ s \\
\text{fst} & = \lambda p.\ p\ \text{tru} \\
\text{snd} & = \lambda p.\ p\ \text{fls}
\end{aligned}
$$
