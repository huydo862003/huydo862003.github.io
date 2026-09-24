---
_type: SoftEngFlashcard
_label: 'What is MongoDB GridFS and when should you use it?'
deck: 'database'
tags:
  - 'database'
concepts:
  - fref("software-engineering/concepts/mongodb-gridfs-concept.td")
---

::: flashcard
What is MongoDB GridFS and when should you use it?
=== key
MongoDB's specification for storing files exceeding the 16 MB BSON limit. Splits files into chunks across `fs.files` (metadata) and `fs.chunks` (data) collections. Use for files > 16 MB or when you need streaming/seeking. For files under 16 MB, just store as BinData in a normal document.
:::
