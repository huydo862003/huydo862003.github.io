---
published: true
author: hdnax
createdAt: "2026-03-28"
updatedAt: "2026-03-28"
question: How to implement classes with prototypes?
answer: TODO
deck: compiler-implementation
concepts:
  - prototype
  - class
books:
  - chapter-4-objects
tags: []
keywords:
  - "prototype"
  - "class"
  - "create"
  - "delegates"
  - "child"
  - "object"
  - "methods"
---


Create a prototype object that contains all the shared methods and default properties.

When you need an instance, create a new empty object and link it to that prototype so it delegates property lookups there.

Add a factory function or constructor that creates these linked objects and initializes their individual properties.

For inheritance, create a child prototype that itself delegates to the parent prototype, forming a chain.

Instances of the child delegate to the child prototype, which in turn delegates to the parent prototype, giving access to methods from both.
