---
_type: PltConcept
_label: 'Valence'
journey: fref("/01-programming-language-theory/index.td")
status: 'reviewing'
books: vault.from_node(self).follow_back(PltBook, "concepts").to_list()
tags:
  - 'syntax & grammar'
flashcards: vault.from_node(self).follow_back(PltFlashcard, "concepts").to_list()
---

The specification of how many variables a subterm binds and what ${fref("/01-programming-language-theory/02-concepts/sort.td")}s (types) those variables have.
