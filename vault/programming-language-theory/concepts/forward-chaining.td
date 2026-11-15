---
_type: PltConcept
_label: 'Forward chaining'
phase: fref("/programming-language-theory/phases/phase-01-foundations-of-program-specification-and-semantics.td")
journey: fref("/programming-language-theory/index.td")
status: 'mastered'
books: vault.from_node(self).follow_back(PltBook, "concepts").to_list()
tags:
  - 'logic'
  - 'proof/reason technique'
  - 'set theory & relation'
flashcards: vault.from_node(self).follow_back(PltFlashcard, "concepts").to_list()
---

A proof technique for ${fref("/programming-language-theory/concepts/judgment-form.td")}s that starts with an ${fref("/programming-language-theory/concepts/axiom.td")} and tries to derive the desired judgment.
