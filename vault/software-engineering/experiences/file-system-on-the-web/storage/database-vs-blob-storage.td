---
_type: ExperienceResource
_label: "Database vs Blob Storage for Files"
experience: fref("software-engineering/experiences/file-system-on-the-web/index.td")
url: "https://engineeringatscale.substack.com/p/when-to-use-blob-storage-vs-database"
kind: 'article'
tags:
  - 'file'
---

Decision guide for choosing between storing files in a database vs blob storage (S3, Azure Blob, etc.). The key argument: decide based on first principles (data size, access patterns, consistency, operational complexity), not convention.

## Two approaches

### In-database

Store binary files directly in the DB (PostgreSQL `bytea`, MySQL `BLOB`, MongoDB GridFS).

- Simple implementation, minimal dependencies.
- Strong consistency out of the box.
- But: large binaries increase memory usage and slow queries.
- Backend servers experience memory pressure, potentially OOM.
- DB size constraints (PostgreSQL: 1 GB/field, MySQL: 4 GB).
- Replication and backups become significantly slower.
- Databases are 5-20x more expensive than blob storage for large binary objects.

### Separated storage

Store metadata + file path in the DB, file content in blob storage.

- DB stays lightweight (metadata is typically under 100 KB per record).
- File uploads can bypass backend servers entirely (pre-signed URLs).
- No practical storage limits.
- Faster backups and replication.
- But: eventual consistency between metadata and content.
- Operational complexity: multi-step uploads, failure handling.
- Dual backup systems.

## Decision matrix

| Attribute | Database | Blob storage |
| --- | --- | --- |
| Consistency | Strong | Eventual |
| Scalability | Limited | High |
| Cost | Expensive | Cost-efficient |
| Simplicity | Simple | Complex |
| Performance | Slower for large files | Faster (CDN, streaming) |

## When to use which

**Database**:
- Files that need ACID with their metadata (invoices, signed forms, inspection photos).
- Small config files (YAML, XML) accessed infrequently.
- Regulated environments needing built-in encryption and audit logging.

**Blob storage**:
- Large files (100 MB+), media assets.
- Billions of files, multi-part uploads.
- Systems needing CDN integration.
- High-throughput applications.

**Hybrid**: Many systems use both. Database for critical tightly-coupled data, blob storage for large scalable assets.

## Takeaways for our system

- Our files are plain text, mostly under 100 KB. This is squarely in "database is fine" territory.
- If we ever need to scale beyond that, the separated approach (metadata in DB, content in blob storage with pre-signed URLs) is the standard upgrade path.
- The pre-signed URL pattern is worth noting: clients upload directly to blob storage, bypassing the backend server entirely. Reduces backend memory pressure.
