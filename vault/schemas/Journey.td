---
_type: schema
properties:
  title:
    type: string
  description:
    type: string
    optional: true
  status:
    type: ['active', 'paused', 'completed']
  tags:
    type: list[string]
    optional: true
---


