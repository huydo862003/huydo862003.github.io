---
_type: PltConcept
_label: 'Untrapped (runtime) error'
journey: fref("/01-programming-language-theory/index.td")
status: 'reviewing'
books: vault.from_node(self).follow_back(PltBook, "concepts").to_list()
tags:
  - 'language feature/design'
  - 'runtime'
  - 'type theory'
flashcards: vault.from_node(self).follow_back(PltFlashcard, "concepts").to_list()
---

According to "Type system" [Luca Cardelli, 1996], a type of errors that does not terminate the program, such as buffer overflows, accessing deallocated memory, type punning gone wrong. These are deemed as dangerous as they can corrupt the program's state.
