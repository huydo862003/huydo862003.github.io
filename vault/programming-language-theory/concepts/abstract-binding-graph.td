---
_type: PltConcept
_label: 'Abstract binding graph'
phase: fref("/programming-language-theory/phases/phase-01-foundations-of-program-specification-and-semantics.td")
journey: fref("/programming-language-theory/index.td")
status: 'learning'
books: vault.from_node(self).follow_back(PltBook, "concepts").to_list()
tags:
  - 'semantics'
  - 'syntax & grammar'
flashcards: vault.from_node(self).follow_back(PltFlashcard, "concepts").to_list()
---

An extension of [Abstract binding tree (ABT)](/plt/concepts/abstract-binding-tree-abt)s to a [Directed acyclic graph (DAG)](/plt/concepts/directed-acyclic-graph-dag) structure while preserving the binding discipline.
