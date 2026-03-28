---
_type: Concept
_label: 'Mathematical induction'
journey: fref("programming-language-theory/index.td")
status: 'learning'
books:
  - fref("programming-language-theory/books/software-foundations/chapter-2-inductive-definitions.td")
---

Formally, assume $n\ \text{nat}$ means that $n$ is a natural number. To prove that whenever $n\ \text{nat}$, we have $\mathcal{P}(n)$, it's sufficient to show that:

1. $\mathcal{P}(\text{zero})$.
2. For every $n$ such that $n\ \text{nat}$, if $\mathcal{P}(n)$ then $\mathcal{P}(\text{succ}(n))$.
