---
_type: Concept
_label: 'Associativity'
title: 'Associativity'
journey: fref("programming-language-theory/index.td")
status: 'mastered'
books:
  - fref("programming-language-theory/books/software-foundations/chapter-1-basics-functional-programming-in-rocq.td")
tags:
  - 'syntax-grammar'
---

A parsing rule that determines grouping when the same operator repeats (left: a - b - c = (a - b) - c; right: a :: b :: c = a :: (b :: c)).

A **parsing rule** that determines grouping when the same operator repeats (left: `a - b - c` = `(a - b) - c`; right: `a :: b :: c` = `a :: (b :: c)`).
