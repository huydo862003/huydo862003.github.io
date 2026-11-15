---
_type: PltConcept
_label: 'Gradual typing macro gradual typing micro gradual typing'
journey: fref("/programming-language-theory/index.td")
status: 'learning'
flashcards: vault.from_node(self).follow_back(PltFlashcard, "concepts").to_list()
---

An approach that allows **mixing typed and untyped code** in the same program, enabling incremental migration from dynamic to static typing.

```scheme
Fully untyped < -  -  -  -  -  -  -  -  -  -  -  -  -  -  - > Fully typed
(Python)           Gradual           (OCaml)
           (TypeScript, Typed Racket)
```
