---
_type: schema
properties:
  journey:
    type: Journey?
  status:
    type: ['learning', 'reviewing', 'mastered']
  tags:
    type: list[string]?
  books:
    type: list[Book]?
  dependsOn:
    type: list[Concept]?
  blocks:
    type: list[Concept]?
---
