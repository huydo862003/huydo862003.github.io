---
_type: PltConcept
_label: 'Polymorphic type system'
journey: fref("/01-programming-language-theory/index.td")
status: 'learning'
books: vault.from_node(self).follow_back(PltBook, "concepts").to_list()
tags:
  - 'language feature/design'
  - 'programming paradigm'
  - 'type theory'
flashcards: vault.from_node(self).follow_back(PltFlashcard, "concepts").to_list()
---

A type system that allows types to contain variables (like List<T>, $\forall$ a. a $\to$ a), enabling one definition to work across many types through type abstraction.

A type system that allows types to contain variables (like `List<T>`, `∀a. a -> a`), enabling one definition to work across many types through type abstraction.
