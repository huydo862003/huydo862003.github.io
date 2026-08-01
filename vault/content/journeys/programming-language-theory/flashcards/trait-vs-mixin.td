---
_type: Flashcard
question: "Trait vs mixin?"
deck: 'pure-lambda-calculus'
concepts:
  - fref("journeys/programming-language-theory/concepts/trait.td")
  - fref("journeys/programming-language-theory/concepts/mixin.td")
books:
  - fref("journeys/programming-language-theory/books/programming-languages-application-and-interpretation/chapter-4-objects.td")
---

::: flashcard
${question}
=== key
Note: Trait in this sense is different from Rust's traits.

- Mixin: A class extension that does not get bound to a specific superclass. Effectively, it's a class-extension function that transforms some specific classes into other classes. Because the mixin generally assume the class to conform to an interface, this encourages good abstractions.
- Trait: A generalization of mixins, in that multiple extensions are applied at once, with a well-define conflict resolution.
:::
