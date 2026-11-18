---
_type: PltConcept
_label: 'Pure/Untyped lambda calculus'
phase: fref("/01-programming-language-theory/phases/phase-01-foundations-of-program-specification-and-semantics.td")
journey: fref("/01-programming-language-theory/index.td")
status: 'learning'
tags:
  - 'formal system'
  - 'lambda calculus'
  - 'semantics'
  - 'syntax & grammar'
  - 'type theory'
---

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
\dfrac{t_1 \to t_1'}{t_1\ t_2 \to t_1'\ t_2} \\ \\
\dfrac{t_2 \to t_2'}{v\ t_2 \to v\ t_2'} \\ \\
(\lambda x.\ t_1)\ t_2 \to [x \to t_2] t_1
\end{array}
$$
