---
_type: schema
_label: "Programming Language Theory Phase"
_icon: icon.layers
_extends: Phase
properties:
  books:
    type: list[Book]?
    computed: (r) -> vault.from_nodes(PltBook).filter((b) -> b.phase == r).to_list()
  concepts:
    type: list[Concept]?
    computed: (r) -> vault.from_nodes(PltConcept).filter((c) -> c.phase == r).to_list()
---
