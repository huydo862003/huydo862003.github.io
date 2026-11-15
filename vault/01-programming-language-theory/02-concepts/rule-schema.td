---
_type: PltConcept
_label: 'Rule schema'
journey: fref("/01-programming-language-theory/index.td")
status: 'reviewing'
books: vault.from_node(self).follow_back(PltBook, "concepts").to_list()
tags:
  - 'logic'
tags:
  - 'logic'
flashcards: vault.from_node(self).follow_back(PltFlashcard, "concepts").to_list()
---

An parameterized inference rules with ${fref("/01-programming-language-theory/02-concepts/metavariable.td")}s that can be instantiated to ${fref("/01-programming-language-theory/02-concepts/concrete-rule.td")}s or ${fref("/01-programming-language-theory/02-concepts/inference-rule.td")}s.
