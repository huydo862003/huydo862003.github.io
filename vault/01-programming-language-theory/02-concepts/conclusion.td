---
_type: PltConcept
_label: 'Conclusion'
journey: fref("/01-programming-language-theory/index.td")
status: 'learning'
books: vault.from_node(self).follow_back(PltBook, "concepts").to_list()
tags:
  - 'logic'
tags:
  - 'logic'
flashcards: vault.from_node(self).follow_back(PltFlashcard, "concepts").to_list()
---

The consequent ${fref("/01-programming-language-theory/02-concepts/judgment.td")} of an ${fref("/01-programming-language-theory/02-concepts/inference-rule.td")} that is derived when all its ${fref("/01-programming-language-theory/02-concepts/premise.td")}s are satisfied.
