---
_type: schema
properties:
  title:
    type: string
  author:
    type: string
    optional: true
  date:
    type: string
    optional: true
  journey:
    type: Journey
    optional: true
  description:
    type: string
    optional: true
  isbn:
    type: string
    optional: true
  url:
    type: string
    optional: true
  cover:
    type: string
    optional: true
  tags:
    type: list[string]
    optional: true
  concepts:
    type: list[Concept]
    optional: true
  parent:
    type: Book
    optional: true
  children:
    type: list[Book]
    optional: true
---


