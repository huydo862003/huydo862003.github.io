---
_type: Concept
title: 'Structural recursion'
journey: fref("journeys/programming-language-theory/index.td")
status: 'reviewing'
books:
  - fref("journeys/programming-language-theory/books/software-foundations/chapter-1-basics-functional-programming-in-rocq.td")
tags:
  - 'data-structure-algorithm'
  - 'language-feature-design'
  - 'programming-paradigm'
---

A recursion scheme that decomposes data along its ${fref("journeys/programming-language-theory/concepts/constructor.td")}s, guaranteeing termination by recursing only on structurally smaller subterms.

A **recursion scheme** that decomposes data along its constructors, guaranteeing termination by recursing only on structurally smaller subterms.
