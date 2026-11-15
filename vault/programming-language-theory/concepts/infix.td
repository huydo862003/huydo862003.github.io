---
_type: PltConcept
_label: 'Infix'
phase: fref("/programming-language-theory/phases/phase-01-foundations-of-program-specification-and-semantics.td")
journey: fref("/programming-language-theory/index.td")
status: 'learning'
books: vault.from_node(self).follow_back(PltBook, "concepts").to_list()
tags:
  - 'syntax & grammar'
flashcards: vault.from_node(self).follow_back(PltFlashcard, "concepts").to_list()
---

A Fixity where an operator appears between its two arguments (like x + y), as opposed to prefix or postfix.

A ${fref("/programming-language-theory/concepts/fixity.td")} where an operator appears between its two arguments (like `x + y`), as opposed to prefix or postfix.
