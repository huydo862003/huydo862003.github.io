---
_type: Flashcard
_label: 'What is language safety, both formally and informally?'
deck: 'programming-language-basic'
concepts:
  - fref("programming-language-theory/concepts/language-safety.td")
books:
  - fref("programming-language-theory/books/types-and-programming-languages/chapter-1-introduction.td")
---

::: flashcard
What is language safety, both formally and informally?
=== key
Informally, a safe language would not allow a programmer to shoot in their foot.

There are various definitions of a safe language:

- Portability: What is the portability perspective on language safety?
- A safe language is one that protects its own abstractions, not allowing an erroneous program to corrupt its state or runtime system.
- A safe language is one that does not have untrapped runtime errors.
:::
