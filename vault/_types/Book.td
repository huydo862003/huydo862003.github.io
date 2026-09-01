---
_type: schema
_label: "Book"
_icon: icon.book
properties:
  author:
    type: string?
  date:
    type: string?
  journey:
    type: Journey?
  description:
    type: string?
  isbn:
    type: string?
  url:
    type: string?
  cover:
    type: string?
  tags:
    type: list[string]?
  concepts:
    type: list[Concept]?
  parent:
    type: Book?
  children:
    type: list[Book]?
---
