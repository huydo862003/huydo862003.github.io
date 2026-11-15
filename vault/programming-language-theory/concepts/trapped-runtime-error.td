---
_type: PltConcept
_label: 'Trapped (runtime) error'
journey: fref("/programming-language-theory/index.td")
status: 'reviewing'
books: vault.from_node(self).follow_back(PltBook, "concepts").to_list()
tags:
  - 'language feature/design'
  - 'runtime'
  - 'type theory'
flashcards: vault.from_node(self).follow_back(PltFlashcard, "concepts").to_list()
---

According to "Type system" [Luca Cardelli, 1996], a type of errors that immediately terminate the program, such as division by zero, array index out-of-bound (in Java, Rust, etc.). These are deemed as safe as they cannot corrupt the program's state.
