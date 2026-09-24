---
_type: SoftEngFlashcard
_label: 'What are the failure modes of the pre-signed URL upload pattern?'
deck: 'architecture'
concepts:
  - fref("software-engineering/concepts/pre-signed-urls.td")
---

::: flashcard
What are the failure modes of the pre-signed URL upload pattern?
=== key
Three modes: (1) DB fails storing metadata: Clean failure, nothing to clean up. (2) Metadata stored but upload fails: Orphaned metadata. Mitigate with `status: 'pending'` + background cleanup job. (3) Upload succeeds but confirmation fails: Use blob storage lifecycle rules to auto-delete unconfirmed objects.
:::
