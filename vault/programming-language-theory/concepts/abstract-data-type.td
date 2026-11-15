---
_type: PltConcept
_label: 'Abstract data type'
journey: fref("/programming-language-theory/index.td")
status: 'mastered'
books: vault.from_node(self).follow_back(PltBook, "concepts").to_list()
tags:
  - 'design principle'
  - 'language feature/design'
  - 'programming paradigm'
flashcards: vault.from_node(self).follow_back(PltFlashcard, "concepts").to_list()
---

A type defined by its operations and their specifications rather than its implementation, providing encapsulation by hiding internal representation while exposing a public interface.
