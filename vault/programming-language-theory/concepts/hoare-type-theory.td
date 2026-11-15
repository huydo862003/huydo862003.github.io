---
_type: PltConcept
_label: 'Hoare type theory'
journey: fref("/programming-language-theory/index.td")
status: 'learning'
books: vault.from_node(self).follow_back(PltBook, "concepts").to_list()
tags:
  - 'formal system'
  - 'logic'
  - 'program analysis'
  - 'proof/reason technique'
  - 'semantics'
flashcards: vault.from_node(self).follow_back(PltFlashcard, "concepts").to_list()
---

A type theory that integrates Hoare-style specifications into types, allowing pre/postconditions and invariants to be expressed and checked within a dependently typed language.

A ${fref("/programming-language-theory/concepts/type-theory.td")} that integrates ${fref("/programming-language-theory/concepts/hoare-logic.td")}-style specifications into types, allowing pre/postconditions and invariants to be expressed and checked within a dependently typed language.
