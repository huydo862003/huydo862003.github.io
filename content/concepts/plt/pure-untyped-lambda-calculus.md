---
published: true
author: hdnax
createdAt: "2026-03-28"
updatedAt: "2026-03-28"
title: Pure/Untyped lambda calculus
journey: plt
status: learning
books:
  - chapter-5-the-untyped-pure-lambda-calculus
dependsOn: []
blocks: []
tags: []
---

\"Pure/Untyped lambda calculus\" is a concept in plt (status: learning).

$$
\begin{array}{l r c l}
\textbf{term} \\
t & ::= & & x           \\
&    & & \lambda x.\ t\\
&    & & t\ t
\\ \\
\textbf{value}\\
v & ::= & & \lambda x.\ t \\ \\
\textbf{evaluation} \\
$$
\dfrac{t_1 \to t_1'}{t_1\ t_2 \to t_1'\ t_2} \\ \\
\dfrac{t_2 \to t_2'}{v\ t_2 \to v\ t_2'} \\ \\
(\lambda x.\ t_1)\ t_2 \to [x \to t_2] t_1
\end{array}
$$
$$
