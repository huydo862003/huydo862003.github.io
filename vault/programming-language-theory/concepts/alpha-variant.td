---
_type: PltConcept
_label: 'Alpha-variant'
journey: fref("/programming-language-theory/index.td")
status: 'mastered'
books: vault.from_node(self).follow_back(PltBook, "concepts").to_list()
tags:
  - 'semantics'
  - 'syntax & grammar'
flashcards: vault.from_node(self).follow_back(PltFlashcard, "concepts").to_list()
---

If two terms are related by the ${fref("/programming-language-theory/concepts/alpha-equivalence.td")} relation, they are alpha-variants.
