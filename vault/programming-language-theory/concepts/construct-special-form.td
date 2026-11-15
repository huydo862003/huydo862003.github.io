---
_type: PltConcept
_label: 'Construct/Special form'
journey: fref("/programming-language-theory/index.td")
status: 'mastered'
books: vault.from_node(self).follow_back(PltBook, "concepts").to_list()
tags:
  - 'language feature/design'
  - 'semantics'
  - 'syntax & grammar'
flashcards: vault.from_node(self).follow_back(PltFlashcard, "concepts").to_list()
---

A built-in language primitive with special evaluation rules that cannot be implemented as a regular function (e.g., `if`, `lambda`, `define` in Lisp). In other words, special forms are necessary for cases where ${fref("/programming-language-theory/concepts/derived-form.td")}s do not suffice.
