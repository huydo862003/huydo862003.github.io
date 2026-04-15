---
published: true
author: hdnax
createdAt: "2026-03-28"
updatedAt: "2026-03-28"
question: What is the untyped calculus of booleans and numbers?
deck: language-theory
concepts: []
books:
  - chapter-3-untyped-arithmetic-expressions
tags: []
---

A simple language with only natural numbers and booleans as primitives.

Terms:

$$
\begin{aligned}
t & := & \text{tru} \\
& \ \vert  & \text{fls} \\
& \  \vert & \text{if}\ t\ \text{then}\ t\ \text{else}\ t \\
& \ \vert  & 0 \\
& \  \vert & \text{succ}\ t \\
& \ \vert  & \text{pred}\ t \\
& \  \vert & \text{iszero}\ t\\
\end{aligned}
$$

Values:

$$
\begin{aligned}
v & := & \text{tru} \\
& \ \vert  & \text{fls} \\
& \  \vert & nv \\
nv & := & 0 \\
& \ \vert  & \text{succ}\ nv
\end{aligned}
$$

Evaluation relation:

$$
\displaystyle\frac{t_1 \to t'_1}{\text{if}\ t_1\ \text{then}\ t_2\ \text{else}\ t_3 \to \text{if}\ t_1'\ \text{then}\ t_2\ \text{else}\ t_3}\\
\text{if}\ \text{tru}\ \text{then}\ t_1\ \text{else}\ t_2 \to t_1\\
\text{if}\ \text{fls}\ \text{then}\ t_1\ \text{else}\ t_2 \to t_2
\\
\\
\displaystyle\frac{t \to t'}{\text{succ}\ t \to \text{succ}\ t'}\\
\text{pred}\ 0 \to 0\\
\text{pred}\ (\text{succ}\ t) \to t \\
\displaystyle\frac{t \to t'}{\text{iszero}\ t \to \text{iszero}\ t'}\\
\text{iszero}\ 0 \to \text{tru}\\
\text{iszero}\ (\text{succ}\ nv) \to \text{fls}
$$
