---
createdAt: "2026-03-28"
updatedAt: "2026-03-28"
question: Using Robert (Bob) Harper's notation, what is the definition of variable substitution?
answer: TODO
deck: language-theory
concepts:
  - capture-avoiding-substitution
books:
  - chapter-1-abstract-syntax
---


Given:

- A set of variables $\mathcal{X}$.
- A set of sorts $\mathcal{S}$.
- A sort-indexed family of ABTs $\mathcal{B} = \{\mathcal{B}_s\}$.
- An arity-indexed family of operators $\mathcal{O}$.

For a term $b$ and variable $x$, a variable substitution is a partial function $[b/x]$ such that:

- If $x \in \mathcal{X}$ then $[b/x]x = b$.
- If $y \in \mathcal{X}$ and $x \neq y$ then $[b/x]y = y$.
- If $o \in \mathcal{O}$, if $\vec{x}_i \notin b$  then $[b/x]o(\vec{x}_1.a_1; \dots; \vec{x}_n.a_n)= o(\vec{x}_1.a'_1; \dots; \vec{x}_n.a'_n)$ such that $a'_i = [b/x]a_i$ when $x \notin \vec{x}_i$, else $a_i' = a_i$.
