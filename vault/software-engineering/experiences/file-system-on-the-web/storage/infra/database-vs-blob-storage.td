---
_type: ExperienceResource
_label: "Database vs Blob Storage for Files"
experience: fref("software-engineering/experiences/file-system-on-the-web/index.td")
url: "https://engineeringatscale.substack.com/p/when-to-use-blob-storage-vs-database"
kind: 'article'
tags:
  - 'file'
---

Decision guide for choosing between storing files in a database vs blob storage (S3, Azure Blob, etc.). The key argument: Decide based on first principles (data size, access patterns, consistency, operational complexity), not convention.

::: tip
**Quick guide**:
- Small files + ACID needed -> Database. Simple, strong consistency, single backup.
- Large files (100 MB+) or high throughput -> Blob storage. Cheap, scalable, CDN-friendly.
- Both -> Hybrid. DB for critical tightly-coupled data, blob storage for large scalable assets.
:::

Decision matrix

| Attribute | Database | Blob storage |
| --- | --- | --- |
| Consistency | Strong | Eventual |
| Scalability | Limited | High |
| Cost | Expensive | Cost-efficient |
| Simplicity | Simple | Complex |
| File size | Limited (1 GB/4 GB) | Unlimited |
| Performance | Slower for large files | Faster (CDN, streaming) |

## Approach 1: In-Database

Store binary files directly in the DB (PostgreSQL `bytea`, MySQL `BLOB`, MongoDB GridFS).

Pros:

- Simple implementation, minimal dependencies.
- Strong consistency out of the box.
- Single backup system (files replicate with the DB).

Cons:

- Large binaries increase memory usage and slow queries. Backend servers can OOM when serving file content through the application layer.
- DB size constraints (PostgreSQL: 1 GB/field, MySQL: 4 GB).
- Replication and backups become significantly slower.
- Databases are 5-20x more expensive than blob storage for large binary objects.

## Approach 2: Separated Storage

> This one is essentially out of database + pointer to remote storage.

Store metadata + file path in the DB, file content in blob storage (S3, Azure Blob, etc.).

The upload flow with pre-signed URLs:

1. Client requests upload from backend.
2. Backend stores metadata in DB and generates a pre-signed URL for the blob store.
3. Client uploads file content directly to blob storage using that URL, bypassing the backend entirely.

This keeps the backend lightweight since file bytes never touch the application server.

**Error handling**: This is a distributed transaction without a coordinator, so failures at each step need different handling:

1. **DB fails storing metadata**: Clean failure. No URL generated, client gets an error. Nothing to clean up.
2. **Metadata stored, but client upload to blob fails**: Orphaned metadata in DB pointing to a nonexistent file.
3. **File uploaded, but confirmation back to backend fails**: File exists in blob storage but metadata is stuck incomplete.

Common mitigations:

- Store metadata with `status: 'pending'`. Only flip to `'complete'` after the client confirms successful upload.
- A background job periodically cleans up stale pending records (e.g. pending for > 15 minutes).
- Pre-signed URLs have a TTL (a few minutes). If the upload didn't happen, the metadata is clearly orphaned.
- Blob storage lifecycle rules can auto-delete unconfirmed objects (e.g. S3 lifecycle policies on a staging prefix).

Pros:

- DB stays lightweight (metadata is typically under 100 KB per record).
- No practical storage limits.
- Faster backups and replication.
- Reads also bypass the backend: Files are served directly from blob storage (+ CDN). Same bypass pattern as uploads.

Cons:

- Eventual consistency between metadata and content. A failed upload can leave orphaned metadata or vice versa.
- Operational complexity: Multi-step uploads, failure handling, retry logic.
- Dual backup systems (DB + blob store).

## When to Use Which

**Database**:

- Files that need ACID with their metadata (invoices, signed forms, inspection photos). E.g. a payment receipt must be persisted atomically with the transaction; a multi-step upload where the receipt could fail separately is not acceptable.
- Small config files (YAML, XML) that are rarely accessed via UI and only read once during startup.
- Regulated environments needing built-in encryption and audit logging.

**Blob storage**:

- Large files (100 MB+), media assets (e.g. WhatsApp, Instagram cannot practically store media in databases).
- Billions of files, multi-part uploads.
- Systems needing CDN integration.
- High-throughput applications.

**Hybrid**: Many systems use both.

## Takeaways for Our System

- Our files are plain text, up to 20k LOC (around 1-2 MB). This is in "database is fine" territory.
- If we ever need to scale beyond that, the separated approach (metadata in DB, content in blob storage with pre-signed URLs) is the standard upgrade path.
- The pre-signed URL pattern is worth noting even at our scale: If backend memory becomes a concern, we can offload file serving without changing the metadata layer.
