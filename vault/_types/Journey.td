---
_type: schema
_label: "Journey"
_icon: icon.compass
properties:
  description:
    type: string?
  status:
    type: ['active', 'paused', 'completed']
  tags:
    type: list[string]?
---
