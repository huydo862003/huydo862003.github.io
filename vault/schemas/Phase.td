---
_type: schema
properties:
  title:
    type: string
  journey:
    type: Journey
    optional: true
  status:
    type: ['active', 'on-hold', 'completed']
  order:
    type: number
    optional: true
  books:
    type: list[Book]
    optional: true
  concepts:
    type: list[Concept]
    optional: true
---


