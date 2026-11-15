---
_type: PltConcept
_label: 'Judgment form'
journey: fref("/01-programming-language-theory/index.td")
status: 'mastered'
books: vault.from_node(self).follow_back(PltBook, "concepts").to_list()
tags:
  - 'logic'
  - 'set theory & relation'
flashcards: vault.from_node(self).follow_back(PltFlashcard, "concepts").to_list()
---

Synonymous with an n-place relation. For a unary relation/predicate, a judgment form is usually written as $J\\ -$ or $-\\ J$, with $-$ being a placeholder for some value drawn from the domain of the pr

Synonymous with an n-place relation. For a unary relation/${fref("/01-programming-language-theory/02-concepts/predicate.td")}, a judgment form is usually written as $J\ -$ or $-\ J$, with $-$ being a placeholder for some value drawn from the domain of the predicate.
