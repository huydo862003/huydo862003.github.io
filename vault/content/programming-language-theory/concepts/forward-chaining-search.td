---
_type: Concept
_label: 'Forward chaining search'
title: 'Forward chaining search'
journey: fref("programming-language-theory/index.td")
status: 'reviewing'
books:
  - fref("programming-language-theory/books/software-foundations/chapter-2-inductive-definitions.td")
tags:
  - 'logic'
  - 'proof-reason-technique'
  - 'set-theory-relation'
---

A search strategy for a ${fref("programming-language-theory/concepts/derivation.td")} of a ${fref("programming-language-theory/concepts/judgment-form.td")} that keeps track of the currently derivable judgments (initially the ${fref("programming-language-theory/concepts/axiom.td")}s) and tries to expand the set using the rules at each step.
