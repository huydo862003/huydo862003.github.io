---
createdAt: "2026-03-28"
updatedAt: "2026-03-28"
question: What's the relation between the Y-combinator and the omega combinator?
answer: TODO
deck: pure-lambda-calculus
concepts:
  - divergent-big-omega-combinator
books:
  - chapter-5-the-untyped-pure-lambda-calculus
tags:
  - "divergent big omega combinator"
  - "lambda"
  - "omega"
  - "combinator"
  - "small"
  - "big"
  - "y-combinator"
---


The small omega combinator:

$$
\omega = \lambda x.\ x\ x
$$

The big omega combinator:

$$
\Omega = (\lambda x.\ x\ x)
\ (\lambda x.\ x\ x)
$$

The Y-combinator:

$$
Y = \lambda f.\ (\lambda x.\ f\ x\ x)\ (\lambda x.\ f\ x\ x)
$$

Some similarities in structure:

- Each term in the Y-combinator's body is a slightly modified version of the small omega combinator - $\lambda x.\ f\ x\ x$ vs $\lambda x.\ x\ x$.
- Self-application pattern.
