---
_type: schema
properties:
  title:
    type: string
  url:
    type: string
    optional: true
  author:
    type: string
    optional: true
  journey:
    type: Journey
    optional: true
  latestPost:
    type: string
    optional: true
  lastChecked:
    type: string
    optional: true
  posts:
    type: list[Blog]
    optional: true
---


