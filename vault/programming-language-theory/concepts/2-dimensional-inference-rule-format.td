---
_type: PltConcept
_label: '2-dimensional inference rule format'
journey: fref("/programming-language-theory/index.td")
status: 'learning'
books: vault.from_node(self).follow_back(PltBook, "concepts").to_list()
tags:
  - 'logic'
  - 'set theory & relation'
  - 'syntax & grammar'
flashcards: vault.from_node(self).follow_back(PltFlashcard, "concepts").to_list()
---

A style of formal definition that defines a set inductively as the smallest set closed under the rules - an element is in the set iff it can be derived by a finite ${fref("/programming-language-theory/concepts/derivation-tree.td")} of rule applications.

${fref("/programming-language-theory/concepts/assets/2d-inference-rule.png")}
