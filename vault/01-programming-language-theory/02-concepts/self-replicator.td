---
_type: PltConcept
_label: 'Self-replicator'
journey: fref("/01-programming-language-theory/index.td")
status: 'learning'
books: vault.from_node(self).follow_back(PltBook, "concepts").to_list()
tags:
  - 'lambda calculus'
  - 'semantics'
tags:
  - 'lambda calculus'
  - 'semantics'
flashcards: vault.from_node(self).follow_back(PltFlashcard, "concepts").to_list()
---

Example:

$$
\text{fibo} = \text{fix}\ \lambda f.\ \lambda n.\ \text{if}\ n = 0\ \text{or}\ n = 1\ \text{then}\ 1\ \text{else}\ (f\ (n - 1)) + (f\ (n - 2))
$$
