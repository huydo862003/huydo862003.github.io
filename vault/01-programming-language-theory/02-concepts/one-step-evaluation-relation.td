---
_type: PltConcept
_label: 'One-step evaluation relation'
phase: fref("/01-programming-language-theory/phases/phase-01-foundations-of-program-specification-and-semantics.td")
journey: fref("/01-programming-language-theory/index.td")
status: 'learning'
books: vault.from_node(self).follow_back(PltBook, "concepts").to_list()
tags:
  - 'logic'
  - 'semantics'
  - 'set theory & relation'
flashcards: vault.from_node(self).follow_back(PltFlashcard, "concepts").to_list()
---

A relation defining a single atomic reduction, mapping a term to its immediate successor by applying exactly one reduction rule. The relation is denoted using the symbol $\to$.
