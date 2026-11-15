---
_type: PltConcept
_label: 'Congruence rule'
journey: fref("/01-programming-language-theory/index.td")
status: 'learning'
books: vault.from_node(self).follow_back(PltBook, "concepts").to_list()
tags:
  - 'logic'
  - 'semantics'
tags:
  - 'logic'
  - 'semantics'
flashcards: vault.from_node(self).follow_back(PltFlashcard, "concepts").to_list()
---

A rule specifying how evaluation propagates into subterms, allowing reduction within a syntactic context while preserving the outer structure.
