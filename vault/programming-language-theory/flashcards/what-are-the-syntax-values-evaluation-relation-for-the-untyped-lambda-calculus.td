---
_type: PltFlashcard
_label: 'What are the syntax/values/evaluation relation for the untyped lambda calculus?'
deck: 'pure-lambda-calculus'
concepts:
  - fref("programming-language-theory/concepts/pure-untyped-lambda-calculus.td")
books:
  - fref("programming-language-theory/books/types-and-programming-languages/chapter-5-the-untyped-pure-lambda-calculus.td")
---

::: flashcard
What are the syntax/values/evaluation relation for the untyped lambda calculus?
=== key
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
:::
