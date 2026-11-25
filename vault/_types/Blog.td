---
_type: schema
_label: "Blog"
_icon: icon.article
properties:
  url:
    type: string?
  journey:
    type: Journey?
  site:
    type: Blogsite?
  tags:
    type: list[string]?
  concepts:
    type: list[PltConcept]?
  flashcards:
    type: list[PltFlashcard]?
---
