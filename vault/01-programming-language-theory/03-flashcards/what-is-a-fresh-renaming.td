---
_type: PltFlashcard
_label: 'What is a fresh renaming?'
concepts:
  - fref("/01-programming-language-theory/02-concepts/fresh-renaming.td")
books:
  - fref("/01-programming-language-theory/01-books/02-practical-foundations-for-programming-languages/01-part-i-judgments-and-rules/01-chapter-1-abstract-syntax.td")
tags:
  - 'language theory'
---

::: flashcard{deck="08-Language Theory"}
What is a fresh renaming?
=== key
Given a set of variables $\mathcal{X}$, a set of sorts $\mathcal{S}$, a sort-indexed family of $\mathcal{A} = \{\mathcal{A}_s\}$, then a Fresh renaming relative to $\mathcal{X}$ is a bijection $\rho : \vec{x} \leftrightarrow \vec{x}'$, such that $\vec{x} \notin \mathcal{X}$.
:::
