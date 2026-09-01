---
_type: schema
_label: "Concept"
_icon: icon.lightbulb
properties:
  journey:
    type: Journey?
  status:
    type: ['learning', 'reviewing', 'mastered']
  tags:
    type: list[string]?
  books:
    type: list[Book]?
  depends_on:
    type: list[Concept]?
  blocks:
    type: list[Concept]?
---
