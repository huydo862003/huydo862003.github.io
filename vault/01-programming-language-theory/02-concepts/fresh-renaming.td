---
_type: PltConcept
_label: 'Fresh renaming'
phase: fref("/01-programming-language-theory/phases/phase-01-foundations-of-program-specification-and-semantics.td")
journey: fref("/01-programming-language-theory/index.td")
status: 'learning'
books: vault.from_node(self).follow_back(PltBook, "concepts").to_list()
tags:
  - 'syntax & grammar'
flashcards: vault.from_node(self).follow_back(PltFlashcard, "concepts").to_list()
---

Given a set of variables $\\mathcal{X}$ and a finite sequence of variables $\\vec{x}$, a bijection $\\rho : \\vec{x} \\leftrightarrow \\vec{x}'$ between $\\vec{x}$ and $\\vec{x}'$, where $\\vec{x}'$ is fresh f

Given a set of variables $\mathcal{X}$ and a finite sequence of variables $\vec{x}$, a bijection $\rho : \vec{x} \leftrightarrow \vec{x}'$ between $\vec{x}$ and $\vec{x}'$, where $\vec{x}'$ is fresh for $\mathcal{X}$.
