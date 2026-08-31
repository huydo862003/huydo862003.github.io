---
_type: PltFlashcard
_label: 'What is the usual treatment for the substitution problems (variable capture, etc.)'
deck: 'pure-lambda-calculus'
concepts:
  - fref("programming-language-theory/concepts/capture-avoiding-substitution.td")
books:
  - fref("programming-language-theory/books/types-and-programming-languages/chapter-5-the-untyped-pure-lambda-calculus.td")
---

::: flashcard
What is the usual treatment for the substitution problems (variable capture, etc.)
=== key
Using Capture-avoiding substitution:

- $[x \to s]x = s$
- $[x\to s]y = y\ \text{if}\ x \neq y$
- $[x \to s](t_1\ t_2) = [x \to s]t_1\ [x \to s]t_2$
-
$$
[x \to s]\lambda y.\ t = \begin{cases} \lambda y.\ t & \text{if}\ x = y \\ \lambda y.\ [x \to s]t & \text{if}\ x \neq y \land y \notin FV(s) \end{cases}
$$
:::
