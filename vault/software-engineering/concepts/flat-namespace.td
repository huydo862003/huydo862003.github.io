---
_type: SoftEngConcept
_label: 'Flat Namespace'
journey: fref("software-engineering/index.td")
status: 'learning'
tags:
  - 'architecture'
---

A storage approach where files have a flat name (e.g. `folder/subfolder/file.txt`) with no actual directory objects. Directory structure is derived by splitting the name on a delimiter (usually `/`).

## How It Works

- Each file has a single `name` field containing the full path.
- There are no directory rows or directory objects.
- Directory listing is simulated by prefix queries (e.g. `WHERE name LIKE 'folder/%'`).
- A `path_tokens` column (cached split of the name) can optimize these queries.

## Tradeoffs

- Simpler than a tree (no parent_id, no recursive queries, no cycle detection).
- Renaming a folder means updating every file whose name starts with that folder prefix.
- No way to store directory-level metadata without a separate mechanism.

## Where It Appears

- Supabase Storage: `objects.name` is the full path. `path_tokens` caches the split. `storage.search()` simulates directory listing.
- MongoDB GridFS: Filenames can contain `/` but there is no directory concept.
- S3: Flat key-value store. "Folders" are just common prefixes.
