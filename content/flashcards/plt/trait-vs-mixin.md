---
published: true
author: Hdnax
createdAt: "2026-03-28"
updatedAt: "2026-03-28"
question: Trait vs mixin?
deck: pure-lambda-calculus
concepts:
  - trait
  - mixin
books:
  - chapter-4-objects
tags: []
---

Note: Trait in this sense is different from Rust's traits.

- Mixin: A class extension that does not get bound to a specific superclass. Effectively, it's a class-extension function that transforms some specific classes into other classes. Because the mixin generally assume the class to conform to an interface, this encourages good abstractions.
- Trait: A generalization of mixins, in that multiple extensions are applied at once, with a well-define conflict resolution.
