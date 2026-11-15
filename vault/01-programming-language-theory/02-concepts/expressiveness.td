---
_type: PltConcept
_label: 'Expressiveness'
journey: fref("/01-programming-language-theory/index.td")
status: 'mastered'
books: vault.from_node(self).follow_back(PltBook, "concepts").to_list()
tags:
  - 'computation theory'
  - 'language feature/design'
  - 'linguistics'
  - 'type theory'
flashcards: vault.from_node(self).follow_back(PltFlashcard, "concepts").to_list()
---

::: info
(Language feature/design) The **ease and directness** of expressing programmer intent - a more expressive feature allows saying something **concisely** and **naturally** (e.g., pattern matching expresses variant dispatch more directly than chains of predicates + accessors; list comprehensions express transformations more naturally than explicit loops); distinct from computational power since both may be Turing-complete but differ in **convenience**.
:::
