---
_type: schema
properties:
  journey:
    type: Journey
    optional: true
  status:
    type: ['learning', 'reviewing', 'mastered']
  tags:
    type: list[string]
    optional: true
  books:
    type: list[Book]
    optional: true
  dependsOn:
    type: list[Concept]
    optional: true
  blocks:
    type: list[Concept]
    optional: true
---


