---
_type: PltConcept
_label: 'Structural induction modulo fresh renaming'
journey: fref("/01-programming-language-theory/index.td")
status: 'mastered'
books: vault.from_node(self).follow_back(PltBook, "concepts").to_list()
tags:
  - 'proof/reason technique'
  - 'syntax & grammar'
flashcards: vault.from_node(self).follow_back(PltFlashcard, "concepts").to_list()
---

To show that $\\mathcal{P}[\\mathcal{X}](a)$ holds for every $a \\in \\mathcal{B}[\\mathcal{X}]$, it is enough to show the following:

- Formulation

    Consider:

  - A set of sorts $\mathcal{S}$.
  - A set of variables $\mathcal{X}$.
  - A predicate $\mathcal{P}$ that is parameterized by $\mathcal{X}$ and $s$.
  - A set of ${fref("/01-programming-language-theory/02-concepts/abstract-binding-tree-abt.td")} $\mathcal{B}$ with ${fref("/01-programming-language-theory/02-concepts/free-variable.td")}s in $\mathcal{X}$.

    To show that $\mathcal{P}[\mathcal{X}](a)$ holds for every $a \in \mathcal{B}[\mathcal{X}]$, it is enough to show the following:

  1. If $x \in \mathcal{X}_s$, then $\mathcal{P}[\mathcal{X}]_s(x)$.
  2. For every $o$ of arity $(\vec{s}_1.s_1;\dots;\vec{s}_n.s_n).s$, if for each $1 \le i \le n$, $\mathcal{P}[\mathcal{X},\vec{x}'_i]_{s_i}(\hat{\rho}_i(a_i))$ for every $\rho_i : \vec{x}_i \leftrightarrow \vec{x}_i'$ with $\vec{x}'_i \notin \mathcal{X}$, then $\mathcal{P}[\mathcal{X}]_s (o(\vec{x}_1.a_1 ; \dots ;\vec{x}_n .a_n))$.
