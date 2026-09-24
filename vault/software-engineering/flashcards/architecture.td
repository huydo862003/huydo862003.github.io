---
_type: SoftEngFlashcard
deck: 'architecture'
concepts:
  - fref("software-engineering/concepts/pre-signed-urls.td")
  - fref("software-engineering/concepts/chunked-file-transfer.td")
  - fref("software-engineering/concepts/flat-namespace.td")
---

::: flashcard
What is a pre-signed URL and why use it?
=== A temporary authenticated URL that lets a client upload/download directly from blob storage (S3, etc.) without going through the backend. The backend generates the URL but never touches the file bytes. Reduces memory pressure and scales better.
:::

::: flashcard
What are the failure modes of the pre-signed URL upload pattern?
=== Three modes: (1) DB fails storing metadata: Clean failure, nothing to clean up. (2) Metadata stored but upload fails: Orphaned metadata. Mitigate with `status: 'pending'` + background cleanup job. (3) Upload succeeds but confirmation fails: Use blob storage lifecycle rules to auto-delete unconfirmed objects.
:::

::: flashcard
Why use chunked file transfer instead of uploading whole files?
=== Full-file upload ties up server memory for the entire request, requires complete re-upload on failure, and wastes bandwidth on small edits. Chunking solves all three: Only failed/modified chunks are retransmitted, and chunks can transfer in parallel.
:::

::: flashcard
How does chunked transfer enable deduplication?
=== Each chunk is identified by the SHA-256 hash of its content. If the server already has a chunk with the same hash (even from another user), it reuses the existing chunk instead of storing a duplicate.
:::

::: flashcard
What is a flat namespace for file storage and what is the tradeoff?
=== Files have a flat name containing the full path (e.g. `folder/subfolder/file.txt`). No actual directory objects exist. Directory listing is simulated by prefix queries. Simpler than a tree (no parent_id, no recursive queries), but renaming a folder means updating every file whose name starts with that prefix.
:::

::: flashcard
Where do flat namespaces appear in practice?
=== Supabase Storage (objects.name is the full path, path_tokens caches the split). MongoDB GridFS (filenames can contain / but no directory concept). Amazon S3 (flat key-value store, "folders" are just common prefixes).
:::
