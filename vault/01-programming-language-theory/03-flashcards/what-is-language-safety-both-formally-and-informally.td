---
_type: PltFlashcard
_label: 'What is language safety, both formally and informally?'
concepts:
  - fref("/01-programming-language-theory/02-concepts/language-safety.td")
books:
  - fref("/01-programming-language-theory/01-books/01-types-and-programming-languages/01-chapter-1-introduction.td")
tags:
  - 'programming language basic'
---

::: flashcard{deck="programming language basic"}
What is language safety, both formally and informally?
=== key
Informally, a safe language would not allow a programmer to shoot in their foot.

There are various definitions of a safe language:

- Portability: What is the portability perspective on language safety?
- A safe language is one that protects its own abstractions, not allowing an erroneous program to corrupt its state or runtime system.
- A safe language is one that does not have untrapped runtime errors.
:::
