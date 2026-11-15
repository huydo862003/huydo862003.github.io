---
_type: PltConcept
_label: 'Occurrence typing'
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

A type system technique where a variable's type can differ at each occurrence (use) based on what predicates have been checked - the same variable x can have type Number in one branch and String in another. Synonymous with ${fref("/programming-language-theory/concepts/flow-typing.td")}.

A type system technique where a variable's type can **differ at each occurrence** (use) based on what predicates have been checked - the same variable `x` can have type `Number` in one branch and `String` in another. Synonymous with Flow typing.
