---
createdAt: "2026-03-28"
updatedAt: "2026-03-28"
question: What are the syntax/values/evaluation relation for the untyped lambda calculus?
answer: TODO
deck: pure-lambda-calculus
concepts:
  - pure-untyped-lambda-calculus
books:
  - chapter-5-the-untyped-pure-lambda-calculus
tags:
  - "pure untyped lambda calculus"
  - "aligned"
  - "lambda"
  - "begin"
  - "end"
  - "displaystyle"
  - "frac"
---


Syntax:

$$
\begin{aligned}
t & :=  & \lambda x.\ t \\
&   \vert  & t \ t
\end{aligned}
$$

Values:

$$
\begin{aligned}
v & := & \lambda x.\ t
\end{aligned}
$$

Evaluation rules, assuming call by value:

$$
\displaystyle\frac{t_1 \to t_1'}{t_1\ t_2 \to t_1'\ t_2} \\
\\
\displaystyle\frac{t_1 \to t_1'}{v\ t_1 \to v\ t_2} \\
(\lambda x.\ t)\ v \to [x \to v]t
$$
