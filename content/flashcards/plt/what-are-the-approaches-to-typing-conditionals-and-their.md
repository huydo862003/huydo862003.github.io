---
published: true
author: hdnax
createdAt: "2026-03-28"
updatedAt: "2026-03-28"
question: What are the approaches to typing conditionals and their tradeoffs?
deck: type-theory
concepts: []
books:
  - chapter-5-types
tags: []
---

- 1st approach: True and False branches must be of the same types.
    
    Pros:
    
    - Simple to implement and understand.
    - The precise type of the conditionals is mostly unambiguous.
    
    Cons:
    
    - Inflexible: Dynamic dispatches are harder to express, for example.
    - Not expressive.
- 2nd approach: The type of the conditionals is the Union type of both branches.
    
    Pros:
    
    - More flexible: Each branch can return an arbitrary type.
    
    Cons:
    
    - The consumer of the results of conditionals must use some techniques like If-splitting.
- 3rd approach: The type of the conditionals is the least upper bound of both branches.
    
    Pros:
    
    - Flexible.
    
    Cons:
    
    - The exact typing of each branch is lost.
