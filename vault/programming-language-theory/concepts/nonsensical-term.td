---
_type: PltConcept
_label: 'Nonsensical term'
journey: fref("/programming-language-theory/index.td")
status: 'mastered'
books: vault.from_node(self).follow_back(PltBook, "concepts").to_list()
tags:
  - 'semantics'
  - 'syntax & grammar'
flashcards: vault.from_node(self).follow_back(PltFlashcard, "concepts").to_list()
---

Example: In the ${fref("/programming-language-theory/concepts/untyped-calculus-of-booleans-and-numbers.td")}, the followings are nonsensical:

- $\text{succ}\ \text{tru}$
- $\text{if}\ 1\ \text{then}\ ...$
