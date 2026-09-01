---
_type: schema
_label: "Thought"
_icon: icon.sparkles
properties:
  date:
    type: date?
  description:
    type: string?
  archived:
    type: boolean?
  tags:
    type: list[string]?
  concepts:
    type: list[Concept]?
  journeys:
    type: list[Journey]?
---
