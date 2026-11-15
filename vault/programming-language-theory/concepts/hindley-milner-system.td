---
_type: PltConcept
_label: 'Hindley-Milner system'
phase: fref("/programming-language-theory/phases/phase-01-foundations-of-program-specification-and-semantics.td")
journey: fref("/programming-language-theory/index.td")
status: 'learning'
books: vault.from_node(self).follow_back(PltBook, "concepts").to_list()
tags:
  - 'formal system'
  - 'language feature/design'
  - 'type theory'
flashcards: vault.from_node(self).follow_back(PltFlashcard, "concepts").to_list()
---

A type system with complete type inference via constraint generation and unification - automatically determines the most general (principal) type for all expressions without annotations; basis for ML,

A ${fref("/programming-language-theory/concepts/type-system.td")} with **complete type inference** via **constraint generation** and **unification** - automatically determines the **most general (principal) type** for all expressions without annotations; basis for ML, OCaml, Haskell.
