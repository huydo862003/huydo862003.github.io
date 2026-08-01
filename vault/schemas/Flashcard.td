---
_type: schema
properties:
  question:
    type: string
    optional: true
  deck:
    type: string
    optional: true
  tags:
    type: list[string]
    optional: true
  concepts:
    type: list[Concept]
    optional: true
  books:
    type: list[Book]
    optional: true
---


