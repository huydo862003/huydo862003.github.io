---
_type: PltConcept
_label: 'Derivation'
journey: fref("/programming-language-theory/index.td")
status: 'mastered'
books: vault.from_node(self).follow_back(PltBook, "concepts").to_list()
tags:
  - 'logic'
  - 'set theory & relation'
flashcards: vault.from_node(self).follow_back(PltFlashcard, "concepts").to_list()
---

A finite composition of rules, starting with ${fref("/programming-language-theory/concepts/axiom.td")}s and ending with a desired ${fref("/programming-language-theory/concepts/judgment.td")}.
