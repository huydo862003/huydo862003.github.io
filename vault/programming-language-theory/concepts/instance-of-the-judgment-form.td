---
_type: PltConcept
_label: 'Instance of the judgment form'
journey: fref("/programming-language-theory/index.td")
status: 'mastered'
books: vault.from_node(self).follow_back(PltBook, "concepts").to_list()
tags:
  - 'logic'
  - 'set theory & relation'
flashcards: vault.from_node(self).follow_back(PltFlashcard, "concepts").to_list()
---

A ${fref("/programming-language-theory/concepts/judgment-form.td")} applied with one or more values. For a judgment form $-\ J$ and a value $a$, it is written as $a\ J$ or $J\ a$.
