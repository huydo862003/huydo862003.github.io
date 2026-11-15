---
_type: PltConcept
_label: 'Mixin'
phase: fref("/programming-language-theory/phases/phase-01-foundations-of-program-specification-and-semantics.td")
journey: fref("/programming-language-theory/index.td")
status: 'learning'
books: vault.from_node(self).follow_back(PltBook, "concepts").to_list()
tags:
  - 'language feature/design'
  - 'programming paradigm'
  - 'type theory'
flashcards: vault.from_node(self).follow_back(PltFlashcard, "concepts").to_list()
---

A function that transforms a class into another class, typically adding behaviors to it assuming the class conforms to an interface, similar to a ${fref("/programming-language-theory/concepts/class-extension.td")}.
