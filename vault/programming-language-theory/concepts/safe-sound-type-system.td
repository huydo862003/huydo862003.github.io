---
_type: PltConcept
_label: 'Safe/Sound type system'
phase: fref("/programming-language-theory/phases/phase-01-foundations-of-program-specification-and-semantics.td")
journey: fref("/programming-language-theory/index.td")
status: 'learning'
books: vault.from_node(self).follow_back(PltBook, "concepts").to_list()
tags:
  - 'type theory'
flashcards: vault.from_node(self).follow_back(PltFlashcard, "concepts").to_list()
---

A ${fref("/programming-language-theory/concepts/type-system.td")} where the static judgment "term $t$ has type $T$" implies a corresponding semantic property at runtime - formalized as: if the type system accepts a program, execution cannot produce behaviors the types claim to exclude.

A type system where the static judgment "term $t$ has type $T$" implies a corresponding semantic property at runtime - formalized as: if the type system accepts a program, execution cannot produce behaviors the types claim to exclude.
