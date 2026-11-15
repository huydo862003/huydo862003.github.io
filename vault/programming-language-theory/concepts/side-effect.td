---
_type: PltConcept
_label: 'Side-effect'
journey: fref("/programming-language-theory/index.td")
status: 'mastered'
books: vault.from_node(self).follow_back(PltBook, "concepts").to_list()
tags:
  - 'language feature/design'
  - 'programming paradigm'
flashcards: vault.from_node(self).follow_back(PltFlashcard, "concepts").to_list()
---

An observable interaction with the outside world or modification of state beyond returning a value, such as I/O, mutation, or exceptions.
