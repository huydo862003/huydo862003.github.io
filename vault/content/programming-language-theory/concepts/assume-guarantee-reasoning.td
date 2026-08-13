---
_type: Concept
_label: 'Assume-guarantee reasoning'
title: 'Assume-guarantee reasoning'
journey: fref("programming-language-theory/index.td")
status: 'mastered'
books:
  - fref("programming-language-theory/books/programming-languages-application-and-interpretation/chapter-5-types.td")
tags:
  - 'proof-reason-technique'
---

A pattern where interacting components have mutual obligations - one component assumes what another guarantees, and vice versa (e.g., lambda assumes parameter has type $T$, application guarantees it;

A pattern where interacting components have **mutual obligations** - one component **assumes** what another **guarantees**, and vice versa (e.g., lambda assumes parameter has type $T$, application guarantees it; application assumes function returns $U$, lambda guarantees it).
