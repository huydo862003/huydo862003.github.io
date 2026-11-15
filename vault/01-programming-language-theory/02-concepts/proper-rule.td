---
_type: PltConcept
_label: 'Proper rule'
journey: fref("/01-programming-language-theory/index.td")
status: 'mastered'
books: vault.from_node(self).follow_back(PltBook, "concepts").to_list()
tags:
  - 'logic'
  - 'set theory & relation'
flashcards: vault.from_node(self).follow_back(PltFlashcard, "concepts").to_list()
---

An ${fref("/01-programming-language-theory/02-concepts/inference-rule.td")} that is not an ${fref("/01-programming-language-theory/02-concepts/axiom.td")}, in other words, has at least one ${fref("/01-programming-language-theory/02-concepts/premise.td")}s.
