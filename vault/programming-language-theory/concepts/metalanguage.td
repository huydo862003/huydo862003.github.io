---
_type: PltConcept
_label: 'Metalanguage'
phase: fref("/programming-language-theory/phases/phase-01-foundations-of-program-specification-and-semantics.td")
journey: fref("/programming-language-theory/index.td")
status: 'learning'
books: vault.from_node(self).follow_back(PltBook, "concepts").to_list()
tags:
  - 'linguistics'
  - 'syntax & grammar'
flashcards: vault.from_node(self).follow_back(PltFlashcard, "concepts").to_list()
---

The language used to describe, define, or reason about another language (${fref("/programming-language-theory/concepts/object-language.td")}) - e.g., English and mathematical notation when specifying ${fref("/programming-language-theory/concepts/lambda-calculus.td")}.
