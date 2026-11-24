---
_type: PltFlashcard
_label: 'SICP: What is data abstraction?'
deck: 'language theory'
concepts:
  - fref("/01-programming-language-theory/02-concepts/abstract-data-type.td")
books:
  - fref("/01-programming-language-theory/01-books/05-structure-and-interpretation-of-computer-programs/02-chapter-2-building-abstractions-with-data/index.td")
tags:
  - 'programming language basic'
---

::: flashcard
What is data abstraction? What are selectors and constructors?
=== key
*Data abstraction*: The technique of isolating the parts of a program that deal with *how data objects are represented* from the parts that deal with *how data objects are used*.

The interface between these two parts is a set of procedures:
- *Constructors*: Build data objects (e.g. `make-rat`).
- *Selectors*: Extract parts of data objects (e.g. `numer`, `denom`).

Programs operate only on "abstract data" via this interface - they make no assumptions about the concrete representation. This creates *abstraction barriers* between levels of the program.
:::
