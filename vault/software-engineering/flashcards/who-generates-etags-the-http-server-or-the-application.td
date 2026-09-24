---
_type: SoftEngFlashcard
_label: 'Who generates ETags: The HTTP server or the application?'
deck: 'collaboration'
concepts:
  - fref("software-engineering/concepts/optimistic-concurrency-control.td")
---

::: flashcard
Who generates ETags: The HTTP server or the application?
=== key
For static files (JS, CSS, images), the HTTP server (Nginx, Apache) generates ETags automatically from file modification time + size. For dynamic resources (DB-backed content served via API), the application must generate and validate ETags itself.
:::
