---
_type: PltConcept
_label: 'Runtime type dispatch'
journey: fref("/programming-language-theory/index.td")
status: 'reviewing'
books: vault.from_node(self).follow_back(PltBook, "concepts").to_list()
tags:
  - 'language feature/design'
  - 'metaprogramming/self-reflection'
  - 'programming paradigm'
  - 'runtime'
  - 'semantics'
  - 'type theory'
flashcards: vault.from_node(self).follow_back(PltFlashcard, "concepts").to_list()
---

A pattern typically associated with ${fref("/programming-language-theory/concepts/union-type.td")}s in which the type of a value is checked so that specialized logic can be carried out. ${fref("/programming-language-theory/concepts/flow-sensitive-typing.td")} is especially useful.
