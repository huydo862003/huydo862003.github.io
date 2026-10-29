---
_type: schema
_label: "Experience"
_icon: icon.flask
properties:
  description:
    type: string?
  status:
    type: ['active', 'mitigated', 'completed', 'paused']
  tags:
    type: list[string]?
---
