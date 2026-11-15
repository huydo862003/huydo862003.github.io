---
_type: PltConcept
_label: 'Proper rule'
journey: fref("/programming-language-theory/index.td")
status: 'reviewing'
books: vault.from_node(self).follow_back(PltBook, "concepts").to_list()
tags:
  - 'logic'
  - 'set theory & relation'
flashcards: vault.from_node(self).follow_back(PltFlashcard, "concepts").to_list()
---

An ${fref("/programming-language-theory/concepts/inference-rule.td")} that is not an ${fref("/programming-language-theory/concepts/axiom.td")}, in other words, has at least one ${fref("/programming-language-theory/concepts/premise.td")}s.
