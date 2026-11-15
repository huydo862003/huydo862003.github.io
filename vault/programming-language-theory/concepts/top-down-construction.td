---
_type: PltConcept
_label: 'Top-down construction'
journey: fref("/programming-language-theory/index.td")
status: 'reviewing'
books: vault.from_node(self).follow_back(PltBook, "concepts").to_list()
tags:
  - 'logic'
  - 'proof/reason technique'
  - 'set theory & relation'
flashcards: vault.from_node(self).follow_back(PltFlashcard, "concepts").to_list()
---

Synonymous with ${fref("/programming-language-theory/concepts/backward-chaining.td")}.
