---
_type: PltConcept
_label: 'The diamond problem'
journey: fref("/programming-language-theory/index.td")
status: 'mastered'
books: vault.from_node(self).follow_back(PltBook, "concepts").to_list()
tags:
  - 'design principle'
tags:
  - 'design principle'
flashcards: vault.from_node(self).follow_back(PltFlashcard, "concepts").to_list()
---

An ambiguity that arises in ${fref("/programming-language-theory/concepts/multiple-inheritance.td")} when a class inherits from two classes that both inherit from a common ancestor, causing uncertainty about which inherited member to use.
