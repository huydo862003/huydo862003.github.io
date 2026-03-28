---
createdAt: "2026-03-28"
updatedAt: "2026-03-28"
question: Why does type inference cause vague error messages?
answer: TODO
deck: compiler-implementation
concepts:
  - type-inference
books:
  - chapter-5-types
---


Sometimes, multiple types are inferred for a variable at different locations. The question: Which type and which location to report?

Example:

$$
f\ x = \text{if}\ x\ \text{then}\ x + 1\ \text{else}\ 2 
$$

- $x$ can be a boolean, if so, must report error at $x + 1$ in the then branch .
- $x$ can be a number, if so, must report error at $x$ in the condition.
