---
_type: PltConcept
_label: 'Runtime type error'
phase: fref("/programming-language-theory/phases/phase-01-foundations-of-program-specification-and-semantics.td")
journey: fref("/programming-language-theory/index.td")
status: 'mastered'
books: vault.from_node(self).follow_back(PltBook, "concepts").to_list()
tags:
  - 'language feature/design'
  - 'runtime'
  - 'type theory'
flashcards: vault.from_node(self).follow_back(PltFlashcard, "concepts").to_list()
---

According to Types and programming languages, the class of undefined or undesirable behaviors that a ${fref("/programming-language-theory/concepts/type-system.td")} is designed to prevent - whether they are actually eliminated depends on the soundness of the type system.

According to Types and programming languages, the class of undefined or undesirable behaviors that a type system is designed to prevent - **whether they are actually eliminated depends on the soundness of the type system**.
