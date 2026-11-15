---
_type: PltConcept
_label: 'Mixfix'
journey: fref("/programming-language-theory/index.td")
status: 'reviewing'
books: vault.from_node(self).follow_back(PltBook, "concepts").to_list()
tags:
  - 'set theory & relation'
  - 'syntax & grammar'
flashcards: vault.from_node(self).follow_back(PltFlashcard, "concepts").to_list()
---

A notation to write down an instance of an ${fref("/programming-language-theory/concepts/n-place-relation.td")}. For example, for a ternary relation $R$, one can write $\Gamma \vdash t : T$ to denote $(\Gamma, t, T) \in R$.
