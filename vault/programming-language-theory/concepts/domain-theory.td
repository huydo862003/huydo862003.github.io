---
_type: PltConcept
_label: 'Domain theory'
journey: fref("/programming-language-theory/index.td")
status: 'reviewing'
books: vault.from_node(self).follow_back(PltBook, "concepts").to_list()
tags:
  - 'domain theory'
  - 'semantics'
tags:
  - 'domain theory'
  - 'semantics'
flashcards: vault.from_node(self).follow_back(PltFlashcard, "concepts").to_list()
---

A branch of mathematics studying structured sets (domains) with partial orders and continuity, providing foundations for ${fref("/programming-language-theory/concepts/denotational-semantics.td")} - particularly for modeling recursion via ${fref("/programming-language-theory/concepts/fixed-point-combinator.td")}s.
