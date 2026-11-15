---
_type: PltConcept
_label: 'Assertion'
journey: fref("/programming-language-theory/index.td")
status: 'reviewing'
books: vault.from_node(self).follow_back(PltBook, "concepts").to_list()
tags:
  - 'logic'
tags:
  - 'logic'
flashcards: vault.from_node(self).follow_back(PltFlashcard, "concepts").to_list()
---

Synonymous with ${fref("/programming-language-theory/concepts/judgment.td")}.
