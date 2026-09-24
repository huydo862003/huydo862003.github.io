---
_type: SoftEngFlashcard
_label: 'What is a pre-signed URL and why use it?'
deck: 'architecture'
concepts:
  - fref("software-engineering/concepts/pre-signed-urls.td")
---

::: flashcard
What is a pre-signed URL and why use it?
=== key
A temporary authenticated URL that lets a client upload/download directly from blob storage (S3, etc.) without going through the backend. The backend generates the URL but never touches the file bytes. Reduces memory pressure and scales better.
:::
