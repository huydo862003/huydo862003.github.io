---
_type: ExperienceResource
_label: "System Design: Google Drive / Dropbox"
experience: fref("software-engineering/experiences/file-system-on-the-web/index.td")
url: "https://www.pankajtanwar.in/blog/system-design-how-to-design-google-drive-dropbox-a-cloud-file-storage-service"
kind: 'article'
tags:
  - 'file'
  - 'metadata'
  - 'collaboration'
---

System design walkthrough for a cloud file storage service (Google Drive/Dropbox scale: 100M users, ~9,000 QPS, 10 exabytes).

## Core architecture

Four layers, each scaling independently:

- **Client applications** on user devices.
- **Block/object storage** for file chunks (S3 or custom; Dropbox initially used S3, later migrated to in-house Magic Pocket).
- **Metadata database** storing file info (names, sizes, paths, versions) separately from content.
- **Synchronization server** coordinating updates across devices.

::: note
The key split: Metadata != blob storage. They scale independently and use different infrastructure.
:::

## Chunked uploads

Problems with uploading full files: Excessive server memory consumption, request handler tied up for the entire duration, high CPU usage, complete re-upload on failure, and inefficient for small edits.

The solution: Break files into smaller chunks identified by SHA-256 hashes. Chunk size depends on I/O ops per second on storage devices, network bandwidth, average file size, and metadata overhead.

Benefits:

- **Bandwidth optimization**: On failure, only the failing chunk is retried, not the whole file.
- **Partial updates**: Only changed chunks are uploaded. Enables efficient version history at the chunk level.
- **Concurrent processing**: Multiple chunks upload in parallel via multithreading.
- **Deduplication**: Identical chunks (even across users) reference the same stored data by hash.

## Sync mechanisms

### Polling -> Long polling

- Periodic polling is wasteful (mostly empty responses).
- HTTP long polling: server holds the request open and responds immediately when changes happen.
- Mobile clients sync on-demand to save bandwidth.

### Message queues

Async messaging (RabbitMQ, Kafka) with a specific flow:

1. Client modification enters the global **request queue**.
2. Metadata database is updated.
3. Sync service processes the metadata change.
4. Update message pushed to subscribed devices via **response queues**.

This enables horizontal scaling of the sync service.

## Database design

- Relational DB (MySQL) for ACID on concurrent edits. NoSQL trades ACID for performance/scalability, which is not acceptable when multiple users access the same files simultaneously.
- A wrapper/abstraction layer sits between the app and DB + cache, abstracting away sharding complexity.
- Never store file URLs in the DB. Construct them from stored metadata instead. URLs change when storage backends migrate.
- Partitioning: Hash-based (consistent hashing on file IDs) over range-based. Range partitioning (e.g. by first letter of filename) causes unbalanced distribution. Consistent hashing solves the remaining imbalance from naive hashing.

## Supporting infra

- **Caching**: Memcached for hot chunks, LRU eviction.
- **Load balancing**: Round-robin or advanced algorithms.
- **Auth**: Token generation before upload, so auth happens before transmitting large files.

## Takeaways for our system

- **Metadata/content split** is the standard pattern at scale. We're small enough that DB-only works, but this is the upgrade path.
- **Chunked uploads** are overkill for our file sizes (up to 1-2 MB), but the deduplication idea (hash-based identity) could be useful for caching or diffing.
- **Long polling for sync** is simpler than WebSockets and sufficient for file change notifications. Worth considering if we don't need sub-second latency.
- **Message queues for fan-out**: If user A edits a file and users B, C need to know, a response queue per device is a clean pattern.
