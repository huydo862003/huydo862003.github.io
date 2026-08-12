---
_type: Concept
title: 'Prototype class'
journey: fref("programming-language-theory/index.td")
status: 'learning'
---

Create a prototype object that contains all the shared methods and default properties.

When you need an instance, create a new empty object and link it to that prototype so it delegates property lookups there.

Add a factory function or constructor that creates these linked objects and initializes their individual properties.

For ${fref("programming-language-theory/concepts/inheritance.td")}, create a child prototype that itself delegates to the parent prototype, forming a chain.

Instances of the child delegate to the child prototype, which in turn delegates to the parent prototype, giving access to methods from both.
