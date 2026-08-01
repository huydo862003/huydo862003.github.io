---
_type: schema
properties:
  title:
    type: string
  date:
    type: date
    optional: true
  description:
    type: string
    optional: true
  archived:
    type: boolean
    optional: true
  tags:
    type: list[string]
    optional: true
  concepts:
    type: list[Concept]
    optional: true
  journeys:
    type: list[Journey]
    optional: true
---


