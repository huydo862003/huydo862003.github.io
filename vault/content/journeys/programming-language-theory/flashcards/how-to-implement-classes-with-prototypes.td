---
_type: Flashcard
deck: 'compiler-implementation'
concepts:
  - fref("journeys/programming-language-theory/concepts/prototype.td")
  - fref("journeys/programming-language-theory/concepts/class.td")
books:
  - fref("journeys/programming-language-theory/books/programming-languages-application-and-interpretation/chapter-4-objects.td")
---

::: flashcard
How to implement classes with prototypes?
=== key
Create a prototype object that contains all the shared methods and default properties.

When you need an instance, create a new empty object and link it to that prototype so it delegates property lookups there.

Add a factory function or constructor that creates these linked objects and initializes their individual properties.

For inheritance, create a child prototype that itself delegates to the parent prototype, forming a chain.

Instances of the child delegate to the child prototype, which in turn delegates to the parent prototype, giving access to methods from both.
:::
