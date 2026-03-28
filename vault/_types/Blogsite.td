---
_type: schema
properties:
  url:
    type: string?
  author:
    type: string?
  journey:
    type: Journey?
  latestPost:
    type: string?
  lastChecked:
    type: string?
  posts:
    type: list[Blog]?
---
