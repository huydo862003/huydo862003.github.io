---
_type: PltConcept
_label: 'Induction on derivations'
phase: fref("/programming-language-theory/phases/phase-01-foundations-of-program-specification-and-semantics.td")
journey: fref("/programming-language-theory/index.td")
status: 'learning'
books: vault.from_node(self).follow_back(PltBook, "concepts").to_list()
tags:
  - 'linguistics'
  - 'logic'
  - 'proof/reason technique'
  - 'set theory & relation'
  - 'syntax & grammar'
flashcards: vault.from_node(self).follow_back(PltFlashcard, "concepts").to_list()
---

An induction technique in which to prove a specific property about a ${fref("/programming-language-theory/concepts/derivation.td")}, we take the ${fref("/programming-language-theory/concepts/inductive-hypothesis.td")} is that every smaller derivations satisfy that property.
