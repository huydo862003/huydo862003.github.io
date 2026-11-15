---
_type: PltConcept
_label: 'Rule'
journey: fref("/01-programming-language-theory/index.td")
status: 'reviewing'
books: vault.from_node(self).follow_back(PltBook, "concepts").to_list()
tags:
  - 'logic'
tags:
  - 'logic'
flashcards: vault.from_node(self).follow_back(PltFlashcard, "concepts").to_list()
---

Short-hand for ${fref("/01-programming-language-theory/02-concepts/inference-rule.td")}.
