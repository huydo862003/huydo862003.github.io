---
_type: PltConcept
_label: 'Micro gradual typing'
journey: fref("/programming-language-theory/index.td")
status: 'learning'
books: vault.from_node(self).follow_back(PltBook, "concepts").to_list()
tags:
  - 'language feature/design'
  - 'semantics'
  - 'type theory'
flashcards: vault.from_node(self).follow_back(PltFlashcard, "concepts").to_list()
---

A ${fref("/programming-language-theory/concepts/gradual-typing.td")} approach where type annotations can be added to any subset of variables within the same code, freely mixing typed and untyped expressions.

A Gradual typing approach where type annotations can be added to **any subset of variables** within the same code, freely mixing typed and untyped expressions.
