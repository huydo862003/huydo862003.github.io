---
_type: PltFlashcard
_label: 'SICP: Dispatching on type vs data-directed programming vs message passing'
concepts:
  - fref("/01-programming-language-theory/02-concepts/message-passing.td")
books:
  - fref("/01-programming-language-theory/01-books/05-structure-and-interpretation-of-computer-programs/02-chapter-2-building-abstractions-with-data/index.td")
tags:
  - 'language theory'
---

::: flashcard{deck="08-Language Theory"}
Compare dispatching on type, data-directed programming, and message passing for handling generic operations.
=== key
All three are strategies for implementing generic operations over multiple types (decompositions of the operation-and-type table):

| Strategy | Adding new types | Adding new operations |
| --- | --- | --- |
| Dispatching on type | Hard - must modify all existing generic operations | Easy |
| Message passing | Easy | Hard - must modify all existing types |
| Data-directed programming | Easy | Easy |

- *Dispatching on type*: Generic operations pattern-match on a type tag. Each operation is an "intelligent operation". Decomposes the table into rows.
- *Message passing*: Data objects are closures that pattern-match on operation names. Each datum is an "intelligent object". Decomposes the table into columns.
- *Data-directed programming*: A global operation-and-type table with `put`/`get`. Adding a new type only requires adding new entries, no modification of existing code.
:::
