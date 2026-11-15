---
_type: PltConcept
_label: 'Pure type system'
journey: fref("/programming-language-theory/index.td")
status: 'learning'
books: vault.from_node(self).follow_back(PltBook, "concepts").to_list()
tags:
  - 'formal system'
  - 'language feature/design'
  - 'type theory'
flashcards: vault.from_node(self).follow_back(PltFlashcard, "concepts").to_list()
---

A general framework parameterizing typed lambda calculi by a triple (sorts, axioms, rules), unifying systems like ${fref("/programming-language-theory/concepts/simply-typed-lambda-calculus.td")}, System F, and the ${fref("/programming-language-theory/concepts/calculus-of-inductive-construction.td")} under a single formalism.
