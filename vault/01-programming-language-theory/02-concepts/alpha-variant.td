---
_type: PltConcept
_label: 'Alpha-variant'
journey: fref("/01-programming-language-theory/index.td")
status: 'mastered'
books: vault.from_node(self).follow_back(PltBook, "concepts").to_list()
tags:
  - 'semantics'
  - 'syntax & grammar'
flashcards: vault.from_node(self).follow_back(PltFlashcard, "concepts").to_list()
---

If two terms are related by the ${fref("/01-programming-language-theory/02-concepts/alpha-equivalence.td")} relation, they are alpha-variants.
