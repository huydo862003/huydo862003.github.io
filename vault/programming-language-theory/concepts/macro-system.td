---
_type: PltConcept
_label: 'Macro system'
phase: fref("/programming-language-theory/phases/phase-01-foundations-of-program-specification-and-semantics.td")
journey: fref("/programming-language-theory/index.td")
status: 'learning'
books: vault.from_node(self).follow_back(PltBook, "concepts").to_list()
tags:
  - 'language feature/design'
  - 'metaprogramming/self-reflection'
  - 'programming paradigm'
  - 'syntax & grammar'
flashcards: vault.from_node(self).follow_back(PltFlashcard, "concepts").to_list()
---

A language facility that provides programmable syntax transformations through ${fref("/programming-language-theory/concepts/macro.td")}s, enabling users to define new syntactic forms that expand into existing language constructs at compile time.
