---
_type: Flashcard
deck: 'language-theory'
concepts:
  - fref("programming-language-theory/concepts/alpha-equivalence.td")
books:
  - fref("programming-language-theory/books/practical-foundations-for-programming-languages/chapter-1-abstract-syntax.td")
---

::: flashcard
What is the formal definition for alpha-equivalence?
=== key
Alpha-equivalence is a relation $=_\alpha$ on the set of terms/ASTs. Given $\mathcal{A}$ as a set of ASTs. Then:

- $x =_\alpha x$.
- $o(\vec{x}_1.a_1; \dots; \vec{x}_n.a_n) =_\alpha o(\vec{x}'_1.a'_1; \dots; \vec{x}_n'.a'_n)$ if for every $1 \le i \le n$, $\rho_i : \vec{x}_i \leftrightarrow \vec{z}_i$ and $\rho_i' : \vec{x}'_i \leftrightarrow \vec{z}_i$ and $\rho_i(a_i) =_\alpha \rho_i' (a_i')$.
:::
