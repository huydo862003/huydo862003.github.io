---
_type: PltConcept
_label: 'Inheritance'
journey: fref("/01-programming-language-theory/index.td")
status: 'reviewing'
books: vault.from_node(self).follow_back(PltBook, "concepts").to_list()
tags:
  - 'language feature/design'
  - 'programming paradigm'
flashcards: vault.from_node(self).follow_back(PltFlashcard, "concepts").to_list()
---

A mechanism where a class (subclass) derives properties and behaviors from another class (superclass), enabling code reuse and establishing an \"is-a\" relationship between types. This coupling between

A mechanism where a class (${fref("/01-programming-language-theory/02-concepts/subclass.td")}) derives properties and behaviors from another class (${fref("/01-programming-language-theory/02-concepts/supertype.td")}), enabling code reuse and establishing an "is-a" relationship between types. This coupling between code reuse and ${fref("/01-programming-language-theory/02-concepts/subtyping.td")} is one of the core issues of inheritance.
