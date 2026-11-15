---
_type: PltConcept
_label: 'Type error'
journey: fref("/programming-language-theory/index.td")
status: 'reviewing'
books: vault.from_node(self).follow_back(PltBook, "concepts").to_list()
tags:
  - 'type theory'
tags:
  - 'type theory'
flashcards: vault.from_node(self).follow_back(PltFlashcard, "concepts").to_list()
---

According to Programming languages: Application and Interpretation, an inability to construct a proof that a given term has some consistent type.
