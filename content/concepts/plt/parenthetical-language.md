---
createdAt: "2026-03-28"
updatedAt: "2026-03-28"
title: "Parenthetical language"
journey: plt
status: learning
tags: ["language-feature-design", "metaprogramming-self-reflection", "syntax-grammar"]
books: ["chapter-3-syntactic-sugar"]
dependsOn: []
blocks: []
---

```scheme
(define-syntax-rule (or a b) (if a a b))
(or x y) → (if x x y)   ; macro just rearranges list elements
```
