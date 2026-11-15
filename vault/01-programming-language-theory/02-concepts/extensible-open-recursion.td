---
_type: PltConcept
_label: 'Extensible/Open recursion'
journey: fref("/01-programming-language-theory/index.td")
status: 'mastered'
books: vault.from_node(self).follow_back(PltBook, "concepts").to_list()
tags:
  - 'design principle'
  - 'language feature/design'
  - 'programming paradigm'
flashcards: vault.from_node(self).follow_back(PltFlashcard, "concepts").to_list()
---

When utilizing the ${fref("/01-programming-language-theory/02-concepts/class-pattern.td")} to define classes with method calls referencing other methods, a recursion pattern that allows method references to be resolved at call site.
