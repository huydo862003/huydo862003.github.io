---
_type: PltConcept
_label: 'Evaluation strategy'
phase: fref("/programming-language-theory/phases/phase-01-foundations-of-program-specification-and-semantics.td")
journey: fref("/programming-language-theory/index.td")
status: 'learning'
books: vault.from_node(self).follow_back(PltBook, "concepts").to_list()
tags:
  - 'language feature/design'
  - 'semantics'
flashcards: vault.from_node(self).follow_back(PltFlashcard, "concepts").to_list()
---

A specification of which ${fref("/programming-language-theory/concepts/beta-redex-reducible-expression.td")} to reduce and in what order, determining how terms are evaluated (e.g., ${fref("/programming-language-theory/concepts/call-by-value.td")}, ${fref("/programming-language-theory/concepts/call-by-name.td")}, ${fref("/programming-language-theory/concepts/normal-order.td")}).
