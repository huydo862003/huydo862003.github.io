---
_type: PltConcept
_label: 'Gradual typing'
journey: fref("/programming-language-theory/index.td")
status: 'learning'
books: vault.from_node(self).follow_back(PltBook, "concepts").to_list()
tags:
  - 'language feature/design'
  - 'semantics'
  - 'type theory'
flashcards: vault.from_node(self).follow_back(PltFlashcard, "concepts").to_list()
---

Fully untyped <---------------> Fully typed

```scheme
Fully untyped <---------------> Fully typed
(Python)           Gradual           (OCaml)
               (TypeScript, Typed Racket)
```
