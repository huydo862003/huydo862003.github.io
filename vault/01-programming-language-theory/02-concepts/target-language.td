---
_type: PltConcept
_label: 'Target language'
journey: fref("/01-programming-language-theory/index.td")
status: 'mastered'
books: vault.from_node(self).follow_back(PltBook, "concepts").to_list()
tags:
  - 'compiler implementation'
tags:
  - 'compiler implementation'
flashcards: vault.from_node(self).follow_back(PltFlashcard, "concepts").to_list()
---

The language the compiled program is in.
