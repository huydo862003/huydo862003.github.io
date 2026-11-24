---
_type: PltFlashcard
_label: 'What is the usual treatment for the substitution problems (variable capture, etc.)'
concepts:
  - fref("/01-programming-language-theory/02-concepts/capture-avoiding-substitution.td")
books:
  - fref("/01-programming-language-theory/01-books/01-types-and-programming-languages/03-part-i-untyped-systems/03-chapter-5-the-untyped-pure-lambda-calculus.td")
tags:
  - 'pure lambda calculus'
---

::: flashcard{deck="pure lambda calculus"}
What is the usual treatment for the substitution problems (variable capture, etc.)
=== key
Using Capture-avoiding substitution:

- $[x \to s]x = s$
- $[x\to s]y = y\ \text{if}\ x \neq y$
- $[x \to s](t_1\ t_2) = [x \to s]t_1\ [x \to s]t_2$
-
$$
\begin{gathered}
[x \to s]\lambda y.\ t = \begin{cases} \lambda y.\ t & \text{if}\ x = y \\ \lambda y.\ [x \to s]t & \text{if}\ x \neq y \land y \notin FV(s) \end{cases}
\end{gathered}
$$
:::
