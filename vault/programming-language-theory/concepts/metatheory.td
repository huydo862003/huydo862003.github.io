---
_type: PltConcept
_label: 'Metatheory'
phase: fref("/programming-language-theory/phases/phase-01-foundations-of-program-specification-and-semantics.td")
journey: fref("/programming-language-theory/index.td")
status: 'learning'
books: vault.from_node(self).follow_back(PltBook, "concepts").to_list()
tags:
  - 'other mathematics'
flashcards: vault.from_node(self).follow_back(PltFlashcard, "concepts").to_list()
---

The study of properties about a ${fref("/programming-language-theory/concepts/formal-system.td")} (e.g., ${fref("/programming-language-theory/concepts/sound.td")}ness, ${fref("/programming-language-theory/concepts/completeness.td")}, termination), using external reasoning to prove facts about the system itself.
