---
_type: PltConcept
_label: 'Currying'
journey: fref("/programming-language-theory/index.td")
status: 'mastered'
books: vault.from_node(self).follow_back(PltBook, "concepts").to_list()
tags:
  - 'language feature/design'
flashcards: vault.from_node(self).follow_back(PltFlashcard, "concepts").to_list()
---

The act of turning a multi-parameter function into a ${fref("/programming-language-theory/concepts/higher-order-function.td")}  that accepts one argument and returns a partially-applied version of the original function.
