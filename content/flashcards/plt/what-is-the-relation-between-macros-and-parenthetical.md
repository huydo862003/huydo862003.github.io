---
published: true
author: hdnax
createdAt: "2026-03-28"
updatedAt: "2026-03-28"
question: What is the relation between macros and parenthetical language?
deck: compiler-implementation
concepts:
  - macro
books:
  - chapter-3-syntactic-sugar
tags: []
---

It's easier to implement macro systems in parenthetical languages, as syntax and lists have the same structure. Therefore, a macro is literally a function that takes a list and yields another list.
