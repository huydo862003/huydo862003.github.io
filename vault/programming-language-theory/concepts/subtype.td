---
_type: PltConcept
_label: 'Subtype'
journey: fref("/programming-language-theory/index.td")
status: 'mastered'
books: vault.from_node(self).follow_back(PltBook, "concepts").to_list()
tags:
  - 'language feature/design'
  - 'programming paradigm'
  - 'semantics'
  - 'set theory & relation'
  - 'type theory'
flashcards: vault.from_node(self).follow_back(PltFlashcard, "concepts").to_list()
---

A type $X$ that can be used wherever type $Y$ is expected - $X$ is \"more specific\" than $Y$.

A type $X$ that can be **used wherever** type $Y$ is expected - $X$ is "more specific" than $Y$.
