---
_type: PltConcept
_label: 'Flow-sensitive typing'
journey: fref("/programming-language-theory/index.td")
status: 'mastered'
books: vault.from_node(self).follow_back(PltBook, "concepts").to_list()
tags:
  - 'language feature/design'
  - 'program analysis'
  - 'runtime'
  - 'semantics'
  - 'type theory'
flashcards: vault.from_node(self).follow_back(PltFlashcard, "concepts").to_list()
---

Synonym for Flow typing - the type checker is \"sensitive\" to control flow, tracking how conditionals, assignments, and predicates refine types at different program points.

Synonym for ${fref("/programming-language-theory/concepts/flow-typing.td")} - the type checker is "sensitive" to control flow, tracking how **conditionals**, **assignments**, and **predicates** refine types at different program points.
