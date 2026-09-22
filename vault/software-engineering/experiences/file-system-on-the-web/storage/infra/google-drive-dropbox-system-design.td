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

Design a service that allows users to store files securely on remote servers, synchronise them across devices, and upload/download from anywhere. Think of Google Drive or Dropbox.

## Requirements

These are rough requirements, not measurable/quantifiable.

- **Functional**:
  - Upload/download, update, delete files from any device.
  - Files synchronised across all devices the user is logged in.
  - History/versioning of files (snapshotting).
- **Non-functional**:
  - Highly available.
  - Highly reliable: Any uploaded file should never be lost.
  - Support large file uploads.
  - ACID:
    - Upload is all or none (atomic) from the user's POV.
    - Device and server versions must match (consistency).
    - Concurrent transactions don't corrupt data (isolation).
    - Data persists durably.

**Out of scope**: Sharing file access with other users, offline editing.

**Scale estimates**:

| Metric | Value |
| --- | --- |
| Total users | ~100M |
| Daily active users | ~50M |
| QPS | ~9,000 (~500M requests/day) |
| Storage | ~10,000 PB (100M users x 100 files x 1 MB avg) |
| Read/write ratio | ~1:1 |
| Write throughput | ~5 GB/s |
| Cache size (80-20 rule) | ~10 TB |
| Active connections | ~1M/min |

::: details Cache size calculation
Each user accesses ~5 files daily, reading ~200 KB chunks out of 1 MB files. 80% of traffic hits 20% of files: ((50M x 200 KB x 5) x 20) / 100 = 10 TB.
:::

## High-Level Design

The system supports two scenarios: uploading/editing/deleting files, and viewing/searching files.

```mermaid
graph LR
    Clients --> BlockServer[Block Server]
    Clients --> MetadataServer[Metadata Server]
    Clients <--> SyncServer[Synchronization Server]

    BlockServer --> CloudStorage[(Cloud Storage)]
    BlockServer --> MetadataServer

    MetadataServer --> MetadataDB[(Metadata Storage)]

    SyncServer --> MetadataServer
```

Four components:

- **Cloud/block storage**
  - Stores all file chunks.
  - Any cloud approach works (S3, Azure).
  - Dropbox started on S3, later built in-house Magic Pocket (multi-exabyte, block replication across geo regions).
- **Block server**
  - Clients interact with this server to upload and download files.
- **Metadata database**
  - Stores metadata (filename, size, path, chunk indexes, version history).
  - Does NOT store actual files.
- **Synchronization server**
  - Keeps local and remote DBs in sync across devices.

::: note
The key split: Metadata != blob storage. They scale independently and use different infrastructure.
:::

## System APIs

```
upload(uploadToken, fileInfo, userInfo)
edit(authToken, fileInfo, userInfo)
delete(authToken, fileInfo, userInfo)
download(authToken, fileInfo, userInfo)
```

`uploadToken` is generated beforehand when a user requests to upload. This gives an opportunity to authenticate and validate the user before they transmit any file data. If we need to block a user from uploading, the check happens here instead of allowing the whole file to be sent and then discarded.

## Component Design

```mermaid
graph TD
    WebClient[Web Client] --> Internet((Internet))
    MobileClient[Mobile Client] --> Internet
    DesktopClient[Desktop Client] --> Internet

    Internet --> LB[Load Balancers]

    LB --> BlockServer[Block Server]
    LB --> MetadataServers[Metadata Servers]
    LB --> NotificationServer[Notification Server]

    BlockServer --> CloudStorage[(Block/Cloud Storage)]
    BlockServer --> StorageCache[Storage Cache Server]

    MetadataServers --> MetadataDB[(Metadata DB)]
    MetadataServers --> MetadataCache[Metadata Cache Server]

    NotificationServer --> SyncQueue[Synchronization Queue]
    SyncQueue --> MetadataServers
```

### Client

A client application on the user's device talks to the service to upload, download and modify files to backend cloud storage.

#### Upload/Download File

Problems with uploading/downloading full files:

- A 10 MB upload ties up 10 MB of server memory for the entire request.
- The request handler is blocked for the entire duration.
- CPU usage spikes during large transfers.
- If the upload fails at 90%, the whole file must be re-uploaded.
- A one-line edit requires re-uploading the entire file.

#### Handling File Transfer Efficiently

The solution: Divide files into smaller chunks. Chunks are named by the hash of their content.

Benefits:

- **Bandwidth optimization**: Only failing chunks are retried. Only modified chunks are sent on update. Less data = better response time.
- **Storage utilization**: Only modified chunks go to the server on update, not the entire file again.
- **Concurrency**: Multiple chunks upload/download in parallel via multithreading.
- **Version control**: Track modifications at the chunk level for faster lookup and history.

#### How to Calculate Chunk Size

Optimal chunk size depends on:

- I/O ops per second on storage devices.
- Network bandwidth available.
- Average file size in the system.
- Metadata overhead per chunk.

#### How to Implement Synchronization Server

The sync server has two jobs:

1. **Detect what changed**: Server and client both calculate SHA-256 hashes per chunk. On upload, only chunks whose hash differs from the stored version are transmitted. If the server already has a chunk with the same hash (even from another user), it reuses it instead of storing a duplicate (deduplication).
2. **Notify other devices**: Once Client A's changes are processed, the sync server needs to tell Client B. How?

**Polling vs long polling**:

- **Polling**: Client periodically asks "anything new?" Most responses are empty. Wastes bandwidth and puts unnecessary load on the server. No persistent connection.
- **Long polling**: Client sends a request, server holds the connection open until there's actually a change, then responds immediately. Each client holds one open HTTP connection. At the scale estimates above (~1M active connections/min), the server must hold ~1M connections simultaneously.
- **WebSockets**: Also persistent and bidirectional, lower overhead per message (no HTTP headers each time). More complex to implement. The article chose long polling because it's simpler and sufficient for file sync (no need for sub-second bidirectional messaging).

Mobile clients sync on-demand instead of keeping a connection open, to save bandwidth and battery.

::: note
This connection-heavy nature of long polling is why the article introduces message queues next. The sync server alone can't handle that many direct connections. A message queue decouples notification fanout from connection management.
:::

::: details Full walkthrough: What happens when a local file changes?
1. Client A's local watcher detects the file changed.
2. Client A computes SHA-256 hashes for each chunk of the updated file.
3. Client A compares hashes against previously stored hashes. Only chunks with different hashes are modified.
4. Client A uploads only the changed chunks to the block server.
5. Block server stores the new chunks in cloud storage.
6. Metadata server updates the chunk index (which chunks make up the current version of this file).
7. Sync server picks up the metadata change and pushes a notification to Client B and C via long polling (or message queue).
8. Client B and C receive the notification, fetch only the changed chunks, and update their local copies.

At no point is the full file re-uploaded or re-downloaded. Only the changed chunks move across the network.
:::

### Message Queuing Service

Enables asynchronous communication between clients and the sync service at scale (RabbitMQ, Kafka).

All queues live on the message broker (RabbitMQ/Kafka), not on the devices.

Two types of queues:

- **Request queue**: A single global queue shared by all clients. Every modification goes here first.
- **Response queues**: One per device, on the broker. Each device subscribes to its own queue. The device's long-polling connection picks up messages from it.

```
Client A --> [Request Queue] (global, on broker)
                    |
              Sync Service
                    |
    [Response Queue: Client B] (on broker) --> Client B (via long poll)
    [Response Queue: Client C] (on broker) --> Client C (via long poll)
```

Flow:

1. Client A sends a modification to the **request queue**.
2. The request is picked up and the **metadata database** is updated with the new chunk indexes/version.
3. The **sync service** reads the updated metadata and determines which devices need to be notified.
4. An update message is pushed to Client B and C's **response queues** on the broker.
5. Client B and C pick up the messages via their long-polling connections.

Benefits:

- Decouples clients from the sync service (clients don't need a direct connection).
- Enables horizontal scaling of the sync service (multiple instances consume from the same queue).
- Load balancing and elasticity come for free from the queue.

### Metadata Database

Stores metadata and chunk indexes, NOT actual files. Maintains version history.

::: note
A chunk index is the ordered list of chunk hashes that make up a file at a given version:

```
file "report.pdf" version 3:
  chunk 0: hash "abc123"
  chunk 1: hash "def456"
  chunk 2: hash "ghi789"
```
:::

The actual bytes live in cloud storage, addressed by those hashes. A new version just has a different chunk index (only the changed chunks get new hashes).

**Relational vs NoSQL**:

- Multiple users may be on the same file simultaneously, so we need data consistency.
- NoSQL does not support ACID natively (trades it for performance/scalability). We'd need to implement ACID programmatically in the sync service, requiring extra DB configuration (e.g. Cassandra replication factor for consistency).
- Relational (MySQL) supports ACID natively. Harder to scale (requires sharding or master-slave), but this is solvable.
- Solution: A wrapper/abstraction around all databases and cache instead of talking to the DB directly.

::: warning
Never store file URLs in the database. Construct them from stored metadata instead. Storing URLs is fragile: metadata-based construction is more robust and scalable.
:::

**Partitioning**:

- **Range-based** (by first letter of filename):
  - Leads to unbalanced servers.
  - Some letters have far more files than others.
- **Hash-based** (hash of file ID):
  - More uniform distribution.
  - Remaining imbalance solvable via consistent hashing.

### Cloud/Block Storage

Stores all chunks uploaded by users. Since metadata is separate, any cloud storage works (S3, Azure, etc.).

### Caching

Two caches sit between the application and the slower backends:

- **Chunk cache**: Recently accessed file chunks keyed by their hash. When a client needs chunk "abc123", check the cache first before hitting cloud storage.
- **Metadata cache**: Recently accessed file metadata (chunk indexes, file info). Avoids hitting the metadata DB on every request.

Both use LRU (Least Recently Used) eviction: When the cache is full, the least recently accessed entries get evicted. This fits the 80-20 rule from the scale estimates (80% of traffic hits 20% of files).

::: details What is Memcached?
An in-memory key-value store that runs on dedicated servers (its own tier, separate from app and DB servers). Caches frequently accessed data in RAM. Simple (just get/set by key), fast (everything in memory), and horizontally scalable (add more nodes). In the component design diagram above, "Storage Cache Server" and "Metadata Cache Server" are Memcached instances.
:::

### Load Balancing

Sits between the internet and all backend servers (block server, metadata servers, notification server) as shown in the component design diagram. All client traffic enters through the load balancer first. Distributes requests uniformly using round-robin or advanced algorithms.

## Takeaways for Our System

- **Metadata/content split** is the standard pattern at scale. We're small enough that DB-only works, but this is the upgrade path.
- **Chunked uploads** are overkill for our file sizes (up to 1-2 MB), but the deduplication idea (hash-based identity) could be useful for caching or diffing.
- **Long polling for sync** is simpler than WebSockets and sufficient for file change notifications. Worth considering if we don't need sub-second latency.
- **Message queues for fan-out**: If user A edits a file and users B, C need to know, a response queue per device is a clean pattern.
- **DB wrapper layer**: Abstracting away sharding/caching behind a wrapper is a good pattern if we ever need to scale the metadata DB.
