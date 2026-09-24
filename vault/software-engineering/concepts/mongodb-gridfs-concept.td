---
_type: SoftEngConcept
_label: 'MongoDB GridFS'
journey: fref("software-engineering/index.td")
status: 'learning'
tags:
  - 'database'
---

MongoDB's built-in specification for storing files that exceed the 16 MB BSON document limit. Splits files into chunks across two collections.

## How It Works

- `fs.files`: One document per file. Stores metadata (filename, length, chunkSize, uploadDate, contentType).
- `fs.chunks`: One document per chunk. Stores the binary data + sequence number.
- Upload splits the file into 255 KB chunks. Download reassembles them in order.

## When to Use

- Files larger than 16 MB (BSON limit).
- You need streaming or seeking over large files.
- You want file data to replicate with the rest of the DB.

## When NOT to Use

- Files under 16 MB: Store as `BinData` in a normal document.
- High-performance file serving: A dedicated object store (S3) will outperform GridFS.
