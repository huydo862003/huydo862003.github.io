---
_type: PltConcept
_label: 'Preorder'
phase: fref("/programming-language-theory/phases/phase-01-foundations-of-program-specification-and-semantics.td")
journey: fref("/programming-language-theory/index.td")
status: 'learning'
books: vault.from_node(self).follow_back(PltBook, "concepts").to_list()
tags:
  - 'set theory & relation'
flashcards: vault.from_node(self).follow_back(PltFlashcard, "concepts").to_list()
---

A ${fref("/programming-language-theory/concepts/binary-relation.td")} that is ${fref("/programming-language-theory/concepts/reflexive.td")} and ${fref("/programming-language-theory/concepts/transitive.td")}.
