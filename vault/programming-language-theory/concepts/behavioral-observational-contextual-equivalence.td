---
_type: PltConcept
_label: 'Behavioral/Observational/Contextual equivalence'
journey: fref("/programming-language-theory/index.td")
status: 'mastered'
books: vault.from_node(self).follow_back(PltBook, "concepts").to_list()
tags:
  - 'program analysis'
  - 'semantics'
tags:
  - 'program analysis'
  - 'semantics'
flashcards: vault.from_node(self).follow_back(PltFlashcard, "concepts").to_list()
---

Example: $\lambda x.\ x \simeq \lambda x.\ (\lambda y.\ y)\ x$
