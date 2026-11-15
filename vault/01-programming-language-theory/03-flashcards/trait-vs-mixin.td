---
_type: PltFlashcard
_label: 'Trait vs mixin?'
deck: 'pure lambda calculus'
concepts:
  - fref("/01-programming-language-theory/02-concepts/trait.td")
  - fref("/01-programming-language-theory/02-concepts/mixin.td")
books:
  - fref("/01-programming-language-theory/01-books/04-programming-languages-application-and-interpretation/04-chapter-4-objects.td")
tags:
  - 'pure lambda calculus'
---

::: flashcard
Trait vs mixin?
=== key
Note: Trait in this sense is different from Rust's traits.

- Mixin: A class extension that does not get bound to a specific superclass. Effectively, it's a class-extension function that transforms some specific classes into other classes. Because the mixin generally assume the class to conform to an interface, this encourages good abstractions.
- Trait: A generalization of mixins, in that multiple extensions are applied at once, with a well-define conflict resolution.
:::
