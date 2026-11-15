---
_type: PltConcept
_label: 'Closed recursion'
journey: fref("/programming-language-theory/index.td")
status: 'reviewing'
books: vault.from_node(self).follow_back(PltBook, "concepts").to_list()
tags:
  - 'design principle'
  - 'language feature/design'
  - 'programming paradigm'
flashcards: vault.from_node(self).follow_back(PltFlashcard, "concepts").to_list()
---

When utilizing the ${fref("/programming-language-theory/concepts/class.td")} pattern to define classes with method calls referencing other methods, a recursion pattern that causes method reference to be resolved immediately right at class definition.
