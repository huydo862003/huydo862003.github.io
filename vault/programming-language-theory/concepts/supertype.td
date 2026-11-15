---
_type: PltConcept
_label: 'Supertype'
journey: fref("/programming-language-theory/index.td")
status: 'mastered'
books: vault.from_node(self).follow_back(PltBook, "concepts").to_list()
tags:
  - 'semantics'
  - 'set theory & relation'
  - 'type theory'
flashcards: vault.from_node(self).follow_back(PltFlashcard, "concepts").to_list()
---

If $X$ is a ${fref("/programming-language-theory/concepts/subtype.td")} of $Y$ then $Y$ is a supertype of $X$.
