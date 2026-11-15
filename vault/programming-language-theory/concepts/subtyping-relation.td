---
_type: PltConcept
_label: 'Subtyping relation'
phase: fref("/programming-language-theory/phases/phase-01-foundations-of-program-specification-and-semantics.td")
journey: fref("/programming-language-theory/index.td")
status: 'mastered'
books: vault.from_node(self).follow_back(PltBook, "concepts").to_list()
tags:
  - 'semantics'
  - 'set theory & relation'
  - 'type theory'
flashcards: vault.from_node(self).follow_back(PltFlashcard, "concepts").to_list()
---

Written $X <: Y$, a formal ordering on types meaning "$X$ is a ${fref("/programming-language-theory/concepts/subtype.td")} of $Y$" - $X$ substitutes for $Y$.

Written $X <: Y$, a formal ordering on types meaning "$X$ is a ${fref("/programming-language-theory/concepts/subtype.td")} of $Y$" - $X$ **substitutes for** $Y$.
