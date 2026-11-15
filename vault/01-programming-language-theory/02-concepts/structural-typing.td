---
_type: PltConcept
_label: 'Structural typing'
journey: fref("/01-programming-language-theory/index.td")
status: 'mastered'
books: vault.from_node(self).follow_back(PltBook, "concepts").to_list()
tags:
  - 'language feature/design'
  - 'semantics'
  - 'type theory'
flashcards: vault.from_node(self).follow_back(PltFlashcard, "concepts").to_list()
---

A type system where ${fref("/01-programming-language-theory/02-concepts/type-compatibility.td")} is determined by structure, not name - any value with matching shape satisfies the type, regardless of declared class or origin.

A type system where Type compatibility is determined by **structure**, not **name** - any value with matching shape satisfies the type, regardless of declared class or origin.
