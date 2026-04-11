---
createdAt: "2026-03-28"
updatedAt: "2026-03-28"
title: "Parenthetical language"
description: "(define-syntax-rule (or a b) (if a a b))"
journey: plt
status: learning
books: ["chapter-3-syntactic-sugar"]
dependsOn: []
blocks: []
tags:
  - "language-feature-design"
  - "metaprogramming-self-reflection"
  - "syntax-grammar"
  - "parenthetical"
  - "language"
  - "scheme"
  - "define-syntax-rule"
  - "macro"
  - "rearranges"
  - "list"
  - "elements"
---

```scheme
(define-syntax-rule (or a b) (if a a b))
(or x y) → (if x x y)   ; macro just rearranges list elements
```
