---
_type: PltConcept
_label: 'Sum of products (SoP)'
journey: fref("/programming-language-theory/index.td")
status: 'reviewing'
books: vault.from_node(self).follow_back(PltBook, "concepts").to_list()
tags:
  - 'language feature/design'
  - 'type theory'
flashcards: vault.from_node(self).follow_back(PltFlashcard, "concepts").to_list()
---

The structure of ${fref("/programming-language-theory/concepts/algebraic-data-type.td")}s - sum because variants combine via "or" (one of mt or node), product because each variant's fields combine via "and" (a node has v and l and r).

The structure of ${fref("/programming-language-theory/concepts/algebraic-data-type.td")}s - **sum** because variants combine via "or" (one of `mt` or `node`), **product** because each variant's fields combine via "and" (a `node` has `v` and `l` and `r`).
