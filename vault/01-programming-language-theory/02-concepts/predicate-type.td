---
_type: PltConcept
_label: 'Predicate type'
journey: fref("/01-programming-language-theory/index.td")
status: 'reviewing'
books: vault.from_node(self).follow_back(PltBook, "concepts").to_list()
tags:
  - 'language feature/design'
  - 'program analysis'
  - 'runtime'
  - 'semantics'
  - 'type theory'
flashcards: vault.from_node(self).follow_back(PltFlashcard, "concepts").to_list()
---

A function type annotated with what it proves when returning true - e.g., (-> Any Boolean : mt) means \"takes anything, returns Boolean, and when true, input was mt.\" Essentially, a type of a Type pred

A function type annotated with **what it proves** when returning true - e.g., `(-> Any Boolean : mt)` means "takes anything, returns Boolean, and when true, input was `mt`." Essentially, a type of a Type predicate.
