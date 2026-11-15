---
_type: PltConcept
_label: 'Concrete rule'
journey: fref("/programming-language-theory/index.td")
status: 'reviewing'
books: vault.from_node(self).follow_back(PltBook, "concepts").to_list()
tags:
  - 'logic'
tags:
  - 'logic'
flashcards: vault.from_node(self).follow_back(PltFlashcard, "concepts").to_list()
---

A specific instance of a ${fref("/programming-language-theory/concepts/rule-schema.td")} where all ${fref("/programming-language-theory/concepts/metavariable.td")}s are replaced with actual terms - the schema is the general pattern, the concrete rule is a particular instantiation.
