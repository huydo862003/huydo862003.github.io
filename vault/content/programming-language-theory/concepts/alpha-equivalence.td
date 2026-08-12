---
_type: Concept
title: 'Alpha-equivalence'
journey: fref("programming-language-theory/index.td")
status: 'learning'
books:
  - fref("programming-language-theory/books/practical-foundations-for-programming-languages/chapter-1-abstract-syntax.td")
---

Then, $=_\\alpha$ is the strongest Congruence on $\\mathcal{A}$that contains the followings:

- Formal definition according to Practical foundations for programming languages

    Consider:

  - A fixed set of ${fref("programming-language-theory/concepts/sort.td")} $\mathcal{S}$, which categorize ASTs into ${fref("programming-language-theory/concepts/syntactic-category.td")}.
  - A sort-indexed family of Variables $\mathcal{X} = \{ \mathcal{X}_s \}$, where $\mathcal{X}_s$ is the set of variables with sort $\mathcal{S}$. A sequence of variable is written as $\vec{x}$.
  - A sort-indexed family of [Abstract syntax tree (AST)](/plt/concepts/abstract-syntax-tree-ast)s $\mathcal{A} = \{\mathcal{A}_s \}$, where $\mathcal{A}_s$ is the set of ASTs with sort $\mathcal{S}$.
  - An ${fref("programming-language-theory/concepts/arity.td")}-indexed family of ${fref("programming-language-theory/concepts/operator.td")} $\mathcal{O}= \{\mathcal{O}_\alpha\}$, where $\mathcal{O}_\alpha$ is the set of operators with the given arity $\alpha$.
  - A fresh renaming with respect to $\mathcal{X}$ is a bijection $\rho : \vec{x} \leftrightarrow \vec{y}$ such that $\vec{y}$ is fresh in $\mathcal{X}$.

    Then, $=_\alpha$ is the **strongest ${fref("programming-language-theory/concepts/congruence.td")}** on $\mathcal{A}$that contains the followings:

  - For $x \in \mathcal{X}$, then $x =_\alpha x$.
  - For $o \in \mathcal{O}$, then $o(\vec{x}_1.a_1; \dots; \vec{x}_n.a_n) =_\alpha o(\vec{x}'_1.a'_1; \dots; \vec{x}'_n.a'_n)$ if for every $1 \leq i \leq n$, $\hat{\rho}_i(a_i) =_\alpha \hat{\rho}'_i(a'_i)$ for all fresh renamings $\rho_i : \vec{x}_i \leftrightarrow \vec{z}_i$ and $\rho'_i : \vec{x}'_i \leftrightarrow \vec{z}_i$.
