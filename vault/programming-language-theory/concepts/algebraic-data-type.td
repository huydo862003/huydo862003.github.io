---
_type: PltConcept
_label: 'Algebraic data type'
journey: fref("/programming-language-theory/index.td")
status: 'reviewing'
books: vault.from_node(self).follow_back(PltBook, "concepts").to_list()
tags:
  - 'language feature/design'
  - 'programming paradigm'
  - 'type theory'
flashcards: vault.from_node(self).follow_back(PltFlashcard, "concepts").to_list()
---

A composite type formed by combining ${fref("/programming-language-theory/concepts/sum-type.td")}s (variants/tagged unions) and product types (tuples/records), enabling precise modeling of data structures like Option, Result, or tree nodes. Synonymous with [Sum of products (SoP)](/plt/concepts/sum-of-products-sop).
