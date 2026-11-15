---
_type: PltConcept
_label: 'Church boolean'
journey: fref("/01-programming-language-theory/index.td")
status: 'learning'
books: vault.from_node(self).follow_back(PltBook, "concepts").to_list()
tags:
  - 'lambda calculus'
  - 'semantics'
tags:
  - 'lambda calculus'
  - 'semantics'
flashcards: vault.from_node(self).follow_back(PltFlashcard, "concepts").to_list()
---

Encoding:

- $\text{tru} = \lambda f.\ \lambda s.\  f$
- $\text{fls} = \lambda f.\ \lambda s.\ s$
