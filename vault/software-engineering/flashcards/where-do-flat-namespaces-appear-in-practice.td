---
_type: SoftEngFlashcard
_label: 'Where do flat namespaces appear in practice?'
deck: 'architecture'
concepts:
  - fref("software-engineering/concepts/flat-filesystem-namespace.td")
---

::: flashcard
Where do flat namespaces appear in practice?
=== key
Supabase Storage (objects.name is the full path, path_tokens caches the split). MongoDB GridFS (filenames can contain / but no directory concept). Amazon S3 (flat key-value store, "folders" are just common prefixes).
:::
