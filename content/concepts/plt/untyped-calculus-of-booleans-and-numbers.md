---
published: true
author: Hdnax
createdAt: "2026-03-28"
updatedAt: "2026-03-28"
title: Untyped calculus of booleans and numbers
journey: plt
status: learning
books:
  - chapter-3-untyped-arithmetic-expressions
dependsOn: []
blocks: []
tags: []
---

$$
\begin{array}{l r c l}
\textbf{term} \\
t & ::= & & \text{tru}           \\
&    & & \text{fls}\\
&    & & 0\\
&    & & \text{if}\ t\ \text{then}\ t\ \text{else}\ t\\
&    & & \text{succ}\ t\\
&    & & \text{pred}\ t\\
&    & & \text{iszero}\ t\\
\\ \\
\textbf{syntactic category} \\
nv & ::= & & \text{0} \\
&     & & \text{succ}\ nv\\ \\
\textbf{value}\\
v & ::= & & \text{tru} \\
&     & & \text{fls} \\
&     & & nv \\ \\
\textbf{evaluation} \\
\text{if}\ \text{tru}\ \text{then}\ t_1\ \text{else}\ t_2\ \to \ t_1 \\ \\
\text{if}\ \text{fls}\ \text{then}\ t_1\ \text{else}\ t_2\ \to \ t_2 \\ \\
$$
\dfrac{t_0 \to t_0'}{\text{if}\ t_0 \ \text{then}\ t_1\ \text{else}\ t_2 \to \text{if}\ t_0' \ \text{then}\ t_1\ \text{else}\ t_2 } \\ \\
\dfrac{t \to t'}{\text{succ}\ t \to \text{succ}\ t'} \\ \\
\dfrac{t \to t'}{\text{pred}\ t \to \text{pred}\ t'} \\ \\
\text{pred}\ (\text{succ}\ nv) \to nv \\ \\
\text{pred}\ 0 \to 0 \\ \\
\text{iszero}\ 0 \to \text{tru} \\ \\
\text{iszero}\ (\text{succ}\ nv) \to \text{fls} \\ \\
\dfrac{t \to t'}{\text{iszero}\ t \to \text{iszero}\ t'}
\end{array}
$$
$$
