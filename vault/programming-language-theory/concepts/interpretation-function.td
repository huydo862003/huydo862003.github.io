---
_type: PltConcept
_label: 'Interpretation function'
journey: fref("/programming-language-theory/index.td")
status: 'reviewing'
books: vault.from_node(self).follow_back(PltBook, "concepts").to_list()
tags:
  - 'semantics'
tags:
  - 'semantics'
flashcards: vault.from_node(self).follow_back(PltFlashcard, "concepts").to_list()
---

A function mapping syntactic terms to mathematical objects (denotations) in a ${fref("/programming-language-theory/concepts/semantic-domain.td")}, assigning meaning compositionally based on the structure of terms.
