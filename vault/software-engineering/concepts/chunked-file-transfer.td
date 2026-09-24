---
_type: SoftEngConcept
_label: 'Chunked File Transfer'
journey: fref("software-engineering/index.td")
status: 'learning'
tags:
  - 'architecture'
---

A technique where files are split into smaller chunks for upload and download, instead of transferring the whole file at once.

## Why Chunking

Problems with full-file transfer:
- Server memory tied up for the entire file during the request.
- Any failure requires re-uploading the whole file.
- A small edit requires re-uploading everything.

## How It Works

- Files are split into fixed-size chunks (e.g. 255 KB).
- Each chunk is identified by the hash of its content (SHA-256).
- On upload, only chunks whose hash differs from the stored version are transmitted.
- On download, chunks are fetched and reassembled in order.

## Benefits

- **Bandwidth optimization**: Only failed chunks are retried. Only modified chunks are sent on update.
- **Deduplication**: Identical chunks (even across users) reference the same stored data by hash.
- **Concurrency**: Multiple chunks transfer in parallel.
- **Version control**: Track modifications at the chunk level.

## Where It Appears

- Google Drive/Dropbox system design: Core file transfer strategy.
- MongoDB GridFS: Splits files into 255 KB chunks.
