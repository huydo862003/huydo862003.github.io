---
_type: PltConcept
_label: 'Metavariable'
phase: fref("/programming-language-theory/phases/phase-01-foundations-of-program-specification-and-semantics.td")
journey: fref("/programming-language-theory/index.td")
status: 'learning'
books: vault.from_node(self).follow_back(PltBook, "concepts").to_list()
tags:
  - 'linguistics'
  - 'syntax & grammar'
flashcards: vault.from_node(self).follow_back(PltFlashcard, "concepts").to_list()
---

A variable in the ${fref("/programming-language-theory/concepts/metalanguage.td")} that ranges over elements of a ${fref("/programming-language-theory/concepts/syntactic-category.td")} in the object language - e.g., $t$ ranging over terms, $v$ over values, $x$ over variables.
