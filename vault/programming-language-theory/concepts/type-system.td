---
_type: PltConcept
_label: 'Type system'
phase: fref("/programming-language-theory/phases/phase-01-foundations-of-program-specification-and-semantics.td")
journey: fref("/programming-language-theory/index.td")
status: 'learning'
books: vault.from_node(self).follow_back(PltBook, "concepts").to_list()
tags:
  - 'formal system'
  - 'type theory'
flashcards: vault.from_node(self).follow_back(PltFlashcard, "concepts").to_list()
---

A tractable syntactic method for proving the absence of certain program behaviors by classifying phrases according to the kinds of values they compute.
