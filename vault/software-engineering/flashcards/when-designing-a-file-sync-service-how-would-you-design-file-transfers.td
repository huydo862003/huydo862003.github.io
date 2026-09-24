---
_type: SoftEngFlashcard
_label: 'When designing a file sync service like Google Drive or Dropbox, how would you design file transfers?'
deck: 'architecture'
---

::: flashcard
When designing a file sync service like Google Drive or Dropbox, how would you design file transfers?
=== key
Split files into fixed-size chunks (e.g. 255 KB), each identified by its SHA-256 hash. On upload: Only transmit chunks the server does not already have (same hash from any user = deduplication). On update: Only send chunks whose hash changed. Chunks transfer in parallel and failed chunks retry individually without restarting the whole upload. The server reassembles chunks into the final file on download.
:::
