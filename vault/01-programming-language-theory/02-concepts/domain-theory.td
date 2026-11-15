---
_type: PltConcept
_label: 'Domain theory'
journey: fref("/01-programming-language-theory/index.td")
status: 'mastered'
books: vault.from_node(self).follow_back(PltBook, "concepts").to_list()
tags:
  - 'domain theory'
  - 'semantics'
tags:
  - 'domain theory'
  - 'semantics'
flashcards: vault.from_node(self).follow_back(PltFlashcard, "concepts").to_list()
---

A branch of mathematics studying structured sets (domains) with partial orders and continuity, providing foundations for ${fref("/01-programming-language-theory/02-concepts/denotational-semantics.td")} - particularly for modeling recursion via ${fref("/01-programming-language-theory/02-concepts/fixed-point-combinator.td")}s.
