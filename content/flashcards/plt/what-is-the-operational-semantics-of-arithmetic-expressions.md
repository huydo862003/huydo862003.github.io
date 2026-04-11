---
createdAt: "2026-03-28"
updatedAt: "2026-03-28"
question: What is the operational semantics of arithmetic expressions?
answer: TODO
deck: language-theory
concepts:
  - operational-semantics
  - untyped-calculus-of-booleans-and-numbers
books:
  - chapter-3-untyped-arithmetic-expressions
tags: []
keywords:
  - "operational semantics"
  - "untyped calculus of booleans and numbers"
  - "text"
  - "vert"
  - "succ"
  - "else"
  - "pred"
  - "iszero"
---


Combining arithmetic and boolean expressions.

Syntax:

$$
\begin{aligned}
t & := & \text{tru}\\
& \ \vert   & \text{fls}\\
& \  \vert  & \text{if}\ t \ \text{then}\ t\ \text{else}\ t \\
& \ \vert  & \text{succ}\ t \\
& \  \vert & \text{pred}\ t \\
& \ \vert  & \text{iszero}\ t \\
\end{aligned}
$$

Value:

$$
\begin{aligned}
v & := & \text{tru}\\
& \ \vert  & \text{fls} \\
& \  \vert & nv \\
nv & := & \text{0} \\
& \ \vert  & \text{succ}\ nv
\end{aligned}
$$

Evaluation relation:

$$
\displaystyle\frac{t_1 \to t_1'}{\text{if}\ t_1\ \text{then}\ t_2\ \text{else}\ t_3 \to \text{if}\ t_1'\ \text{then}\ t_2\ \text{else}\ t_3}\\
\text{if}\ \text{tru}\ \text{then}\ t_1\ \text{else}\ t_2 \to t_1 \\
\text{if}\ \text{fls}\ \text{then}\ t_1\ \text{else}\ t_2 \to t_2 \\
\\
\displaystyle\frac{t\to t'}{\text{succ}\ t \to \text{succ}\ t'} \\
\displaystyle\frac{t\to t'}{\text{pred}\ t \to \text{pred}\ t'}
\\
\text{pred}\ 0 \to 0 \\
\text{pred}\ (\text{succ}\ t) \to t\\
\displaystyle\frac{t\to t'}{\text{iszero}\ t \to \text{iszero}\ t'}\\
\text{iszero}\ 0 \to \text{tru}\\
\text{iszero}\ (\text{succ}\ nv) \to \text{fls}
$$
