---
_type: ExperienceResource
_label: "MongoDB GridFS"
experience: fref("software-engineering/experiences/file-system-on-the-web/index.td")
url: "https://www.mongodb.com/docs/manual/core/gridfs/"
kind: 'article'
tags:
  - 'file'
---

GridFS is MongoDB's built-in specification for storing files that exceed the 16 MB BSON document limit. It splits files into chunks across two collections.

## Schema

```mermaid
erDiagram
    fs_files ||--o{ fs_chunks : "has many"

    fs_files {
        ObjectId _id PK
        string filename
        number length
        number chunkSize
        Date uploadDate
        string contentType
        document metadata
    }

    fs_chunks {
        ObjectId _id PK
        ObjectId files_id FK
        integer n
        BinData data
    }
```

### `fs.files`

One document per file. Stores metadata.

```json
{
  "_id": ObjectId("..."),
  "filename": "my_file.pdf",
  "length": 5242880,
  "chunkSize": 261120,
  "uploadDate": ISODate("..."),
  "contentType": "application/pdf",
  "metadata": { "author": "John", "version": 1 }
}
```

Fields:

- `_id` (ObjectId): Unique file identifier.
- `filename` (string): File name.
- `length` (number): Total file size in bytes.
- `chunkSize` (number): Size of each chunk. Default is 255 KB (261,120 bytes).
- `uploadDate` (Date): When the file was uploaded.
- `contentType` (string, optional): MIME type.
- `metadata` (document, optional): Custom metadata subdocument.

### `fs.chunks`

One document per chunk. Stores actual data.

```json
{
  "_id": ObjectId("..."),
  "files_id": ObjectId("..."),
  "n": 0,
  "data": BinData(0, "...")
}
```

Fields:

- `files_id` (ObjectId): References `fs.files._id`.
- `n` (integer): Chunk sequence number (0-indexed).
- `data` (BinData): The chunk's binary data.

### Indexes

- `fs.files` has an index on `filename`.
- `fs.chunks` has a compound index on `(files_id, n)` for ordered retrieval.

## How It Works

- **Upload**: File is split into chunks of `chunkSize` bytes.
  - Each chunk is stored as a document in `fs.chunks`.
  - A metadata document is created in `fs.files`.
- **Download**: Query `fs.files` for metadata.
  - Then query `fs.chunks` for all documents with matching `files_id`.
  - Sort by `n`, concatenate data, trim to exact `length`.

```
5 MB file, 255 KB chunks:

fs.files:  { filename: "report.pdf", length: 5242880, chunkSize: 261120 }

fs.chunks: { files_id: ..., n: 0,  data: [255 KB] }
           { files_id: ..., n: 1,  data: [255 KB] }
           ...
           { files_id: ..., n: 19, data: [255 KB] }
           { files_id: ..., n: 20, data: [remaining bytes] }

Total: 21 chunks (20 full + 1 partial)
```

## Key Design Decisions

- **Chunking**: Enables streaming and partial reads without loading entire files into memory.
- **Two collections**: Metadata and content are separated.
  - You can query file metadata without touching the chunks.
- **No hierarchy**: GridFS is flat.
  - Filenames can contain `/` but there is no directory concept.
  - Same approach as Supabase.
- **Different API**: Does not use standard `find`/`insert`.
  - Uses dedicated GridFS driver methods.
  - This is a downside compared to `bytea` which uses normal SQL.

## When to Use GridFS

- Files are larger than 16 MB (BSON limit).
- You need streaming/seeking over large files.
- You want file data to replicate with the rest of the DB.

## When NOT to Use GridFS

- Files are under 16 MB: Just store as `BinData` in a normal document. Simpler and uses the same API as everything else.
- High-performance file serving is needed: A dedicated object store (S3) will outperform GridFS.

## Takeaways for Our System

- GridFS is designed for large binary files. Our files are plain text (up to 1-2 MB), so GridFS is overkill.
- If we use MongoDB, storing file content as a field in a normal document is sufficient.
- The chunking pattern is still interesting for versioning: If we ever need diffs or partial updates, chunk-based storage enables that.
