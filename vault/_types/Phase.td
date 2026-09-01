---
_type: schema
_label: "Phase"
_icon: icon.layers
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
