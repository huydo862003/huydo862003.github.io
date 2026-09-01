---
_type: schema
_label: "Blog Site"
_icon: icon.globe
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
