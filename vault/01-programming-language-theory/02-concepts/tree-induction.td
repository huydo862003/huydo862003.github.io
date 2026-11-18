---
_type: PltConcept
_label: 'Tree induction'
phase: fref("/01-programming-language-theory/phases/phase-01-foundations-of-program-specification-and-semantics.td")
journey: fref("/01-programming-language-theory/index.td")
status: 'mastered'
tags:
  - 'logic'
  - 'proof/reason technique'
  - 'set theory & relation'
---

Formally, assume $a\ \text{tree}$ means that $a$ is a binary tree. To prove that whenever $a\ \text{tree}$, we have $\mathcal{P}(a)$, it's sufficient to show that:

1. $\mathcal{P}(\text{empty)}$.
2. For every $a_1$ and $a_2$ such that $a_1\ \text{tree}$ and $a_2\ \text{tree}$, if $\mathcal{P}(a_1)$ and $\mathcal{P}(a_2)$ then $\mathcal{P}(\text{node}(a_1;a_2))$.
