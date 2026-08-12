---
_type: schema
properties:
  title:
    type: string
  url:
    type: string
    optional: true
  journey:
    type: Journey
    optional: true
  site:
    type: Blogsite
    optional: true
  tags:
    type: list[string]
    optional: true
---


