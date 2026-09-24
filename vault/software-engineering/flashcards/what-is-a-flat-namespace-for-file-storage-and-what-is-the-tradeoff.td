---
_type: SoftEngFlashcard
_label: 'What is a flat namespace for file storage and what is the tradeoff?'
deck: 'architecture'
tags:
  - 'architecture'
concepts:
  - fref("software-engineering/concepts/flat-filesystem-namespace.td")
---

::: flashcard
What is a flat namespace for file storage and what is the tradeoff?
=== key
Files have a flat name containing the full path (e.g. `folder/subfolder/file.txt`). No actual directory objects exist. Directory listing is simulated by prefix queries. Simpler than a tree (no parent_id, no recursive queries), but renaming a folder means updating every file whose name starts with that prefix.
:::
