---
_type: PltConcept
_label: 'Assertion'
journey: fref("/01-programming-language-theory/index.td")
status: 'mastered'
books: vault.from_node(self).follow_back(PltBook, "concepts").to_list()
tags:
  - 'logic'
tags:
  - 'logic'
flashcards: vault.from_node(self).follow_back(PltFlashcard, "concepts").to_list()
---

Synonymous with ${fref("/01-programming-language-theory/02-concepts/judgment.td")}.
