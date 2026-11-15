---
_type: PltConcept
_label: 'Symbol'
journey: fref("/programming-language-theory/index.td")
status: 'reviewing'
books: vault.from_node(self).follow_back(PltBook, "concepts").to_list()
tags:
  - 'syntax & grammar'
flashcards: vault.from_node(self).follow_back(PltFlashcard, "concepts").to_list()
---

As per Practical foundations for programming languages's terminology, an index to the families of operators. Given an ${fref("/programming-language-theory/concepts/indexed-operator.td")} $o$ and a symbol $u$, $o[u]$ is an operator.
