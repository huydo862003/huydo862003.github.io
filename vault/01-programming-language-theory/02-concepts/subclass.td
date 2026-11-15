---
_type: PltConcept
_label: 'Subclass'
journey: fref("/01-programming-language-theory/index.td")
status: 'mastered'
books: vault.from_node(self).follow_back(PltBook, "concepts").to_list()
tags:
  - 'language feature/design'
  - 'programming paradigm'
  - 'semantics'
flashcards: vault.from_node(self).follow_back(PltFlashcard, "concepts").to_list()
---

::: info
(Semantics, Language feature/design, Programming paradigm) A ${fref("/01-programming-language-theory/02-concepts/class.td")} that extends a parent class.
:::
