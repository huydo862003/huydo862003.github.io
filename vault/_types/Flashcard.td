---
_type: schema
_label: "Flashcard"
_icon: icon.graduation
properties:
  question:
    type: string?
  tags:
    type: list[string]?
  concepts:
    type: list[Concept]?
  books:
    type: list[Book]?
---
