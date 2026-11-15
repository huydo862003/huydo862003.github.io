---
_type: PltConcept
_label: 'Concrete rule'
journey: fref("/01-programming-language-theory/index.td")
status: 'reviewing'
books: vault.from_node(self).follow_back(PltBook, "concepts").to_list()
tags:
  - 'logic'
tags:
  - 'logic'
flashcards: vault.from_node(self).follow_back(PltFlashcard, "concepts").to_list()
---

A specific instance of a ${fref("/01-programming-language-theory/02-concepts/rule-schema.td")} where all ${fref("/01-programming-language-theory/02-concepts/metavariable.td")}s are replaced with actual terms - the schema is the general pattern, the concrete rule is a particular instantiation.
