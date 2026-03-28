---
_type: schema
properties:
  journey:
    type: Journey?
  status:
    type: ['active', 'on hold', 'completed']
  order:
    type: number?
  books:
    type: list[Book]?
  concepts:
    type: list[Concept]?
---
