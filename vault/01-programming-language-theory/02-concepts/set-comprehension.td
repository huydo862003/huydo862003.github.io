---
_type: PltConcept
_label: 'Set comprehension'
journey: fref("/01-programming-language-theory/index.td")
status: 'mastered'
books: vault.from_node(self).follow_back(PltBook, "concepts").to_list()
tags:
  - 'set theory & relation'
flashcards: vault.from_node(self).follow_back(PltFlashcard, "concepts").to_list()
---

Example: $\mathbb{Q} = \{\displaystyle \frac{p}{q}\ |\ p \in \mathbb{Z} \land q \in \mathbb{Z} \land q \neq 0 \}$.
