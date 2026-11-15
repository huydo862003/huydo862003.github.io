---
_type: PltConcept
_label: 'Rule schema'
journey: fref("/programming-language-theory/index.td")
status: 'reviewing'
books: vault.from_node(self).follow_back(PltBook, "concepts").to_list()
tags:
  - 'logic'
tags:
  - 'logic'
flashcards: vault.from_node(self).follow_back(PltFlashcard, "concepts").to_list()
---

An parameterized inference rules with ${fref("/programming-language-theory/concepts/metavariable.td")}s that can be instantiated to ${fref("/programming-language-theory/concepts/concrete-rule.td")}s or ${fref("/programming-language-theory/concepts/inference-rule.td")}s.
