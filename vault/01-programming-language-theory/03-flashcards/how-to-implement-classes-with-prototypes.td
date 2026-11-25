---
_type: PltFlashcard
_label: 'How to implement classes with prototypes?'
concepts:
  - fref("/01-programming-language-theory/02-concepts/prototype.td")
  - fref("/01-programming-language-theory/02-concepts/class.td")
books:
  - fref("/01-programming-language-theory/01-books/04-programming-languages-application-and-interpretation/04-chapter-4-objects.td")
tags:
  - 'compiler implementation'
  - 'programming language basic'
  - 'language theory'
---

::: flashcard{deck="13-Compiler Implementation"}
How to implement classes with prototypes?
=== key
Create a prototype object that contains all the shared methods and default properties.

When you need an instance, create a new empty object and link it to that prototype so it delegates property lookups there.

Add a factory function or constructor that creates these linked objects and initializes their individual properties.

For inheritance, create a child prototype that itself delegates to the parent prototype, forming a chain.

Instances of the child delegate to the child prototype, which in turn delegates to the parent prototype, giving access to methods from both.
:::
