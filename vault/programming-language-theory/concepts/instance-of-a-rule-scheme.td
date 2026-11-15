---
_type: PltConcept
_label: 'Instance of a rule scheme'
journey: fref("/programming-language-theory/index.td")
status: 'mastered'
books: vault.from_node(self).follow_back(PltBook, "concepts").to_list()
tags:
  - 'logic'
  - 'set theory & relation'
flashcards: vault.from_node(self).follow_back(PltFlashcard, "concepts").to_list()
---

Synonymous with ${fref("/programming-language-theory/concepts/instance-of-an-inference-rule.td")}.
