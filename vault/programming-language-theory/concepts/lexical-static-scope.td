---
_type: PltConcept
_label: 'Lexical/Static scope'
phase: fref("/programming-language-theory/phases/phase-01-foundations-of-program-specification-and-semantics.td")
journey: fref("/programming-language-theory/index.td")
status: 'mastered'
books: vault.from_node(self).follow_back(PltBook, "concepts").to_list()
tags:
  - 'language feature/design'
  - 'semantics'
flashcards: vault.from_node(self).follow_back(PltFlashcard, "concepts").to_list()
---

A ${fref("/programming-language-theory/concepts/binding.td")} resolution strategy where a variable's binding is determined by its textual position in the source code - the enclosing ${fref("/programming-language-theory/concepts/scope.td")} at the point of definition, not the call site at runtime.
