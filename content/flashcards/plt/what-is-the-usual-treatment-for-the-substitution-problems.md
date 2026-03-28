---
createdAt: "2026-03-28"
updatedAt: "2026-03-28"
question: What is the usual treatment for the substitution problems (variable capture, etc.)
answer: TODO
deck: pure-lambda-calculus
concepts:
  - capture-avoiding-substitution
books:
  - chapter-5-the-untyped-pure-lambda-calculus
---


Using Capture-avoiding substitution:

- $[x \to s]x = s$
- $[x\to s]y = y\ \text{if}\ x \neq y$
- $[x \to s](t_1\ t_2) = [x \to s]t_1\ [x \to s]t_2$
- 
$$
[x \to s]\lambda y.\ t = \begin{cases} \lambda y.\ t & \text{if}\ x = y \\ \lambda y.\ [x \to s]t & \text{if}\ x \neq y \land y \notin FV(s) \end{cases}
$$

