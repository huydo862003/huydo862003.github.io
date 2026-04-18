---
published: true
author: Hdnax
createdAt: "2026-03-28"
updatedAt: "2026-03-28"
question: How to utilize the property of word-aligned addresses to optimize number's placements?
deck: compiler-implementation
concepts: []
books:
  - chapter-5-types
tags: []
---

- In languages that mostly allocate memory for objects on the heap.
- These memory should in most case be word-aligned.
    
    → The pointers would contain `00` at the end.
    
    → Use this as a tag to differentiate numbers.
