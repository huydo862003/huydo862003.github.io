---
_type: SoftEngFlashcard
_label: 'What is the ETag + If-Match pattern in HTTP?'
deck: 'collaboration'
tags:
  - 'collaboration'
concepts:
  - fref("software-engineering/concepts/optimistic-concurrency-control.td")
---

::: flashcard
What is the ETag + If-Match pattern in HTTP?
=== key
GET returns an ETag header (opaque version token). On PUT/DELETE, client sends `If-Match: "<etag>"`. Server rejects with 412 Precondition Failed if the ETag changed. This is optimistic concurrency control built into HTTP.
:::
