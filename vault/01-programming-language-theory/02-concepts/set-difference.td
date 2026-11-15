---
_type: PltConcept
_label: 'Set difference'
journey: fref("/01-programming-language-theory/index.td")
status: 'mastered'
books: vault.from_node(self).follow_back(PltBook, "concepts").to_list()
tags:
  - 'set theory & relation'
flashcards: vault.from_node(self).follow_back(PltFlashcard, "concepts").to_list()
---

Definition: $R - Q = \{x \ | \ x \in R \land \ x \notin Q \}$.
