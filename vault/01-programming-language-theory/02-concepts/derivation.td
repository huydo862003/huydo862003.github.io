---
_type: PltConcept
_label: 'Derivation'
journey: fref("/01-programming-language-theory/index.td")
status: 'mastered'
books: vault.from_node(self).follow_back(PltBook, "concepts").to_list()
tags:
  - 'logic'
  - 'set theory & relation'
flashcards: vault.from_node(self).follow_back(PltFlashcard, "concepts").to_list()
---

A finite composition of rules, starting with ${fref("/01-programming-language-theory/02-concepts/axiom.td")}s and ending with a desired ${fref("/01-programming-language-theory/02-concepts/judgment.td")}.
