---
_type: ExperienceResource
_label: "Supabase Storage: Database Schema"
experience: fref("software-engineering/experiences/file-system-on-the-web/index.td")
url: "https://supabase.com/docs/guides/storage/schema/design"
kind: 'article'
tags:
  - 'metadata'
---

Supabase Storage is an open-source file storage service built on PostgreSQL + S3.

- Metadata lives in Postgres.
- Actual file content lives in an external object store (S3 or compatible).

Source code: https://github.com/supabase/storage

## Background: Supabase Storage Concepts

- **Bucket**:
  - A top-level container for files (like an S3 bucket).
  - Each bucket has its own configuration:
    - Public/private visibility.
    - Max file size limit.
    - Allowed MIME types.
  - A project can have multiple buckets (e.g. `avatars`, `documents`, `attachments`).
- **Object**:
  - A file within a bucket.
  - Identified by its `name` (a `/`-delimited path like `folder/subfolder/file.txt`).
  - The name is the full path, not just the filename.
- **Flat namespace**:
  - There are no actual folder objects.
  - Folders are implied by the `/` separators in object names.
  - `storage.search()` simulates directory listing by splitting names at a given depth.
- **RLS (Row Level Security)**:
  - Access control is enforced at the Postgres level via RLS policies on the `objects` table, not in application code.
  - Supabase provides helper functions (`auth.uid()`, `auth.role()`) for writing policies.
- **All operations go through the API**: The docs strongly recommend never modifying the storage tables directly. Orphaned metadata (rows without corresponding files in S3) remains billable.

## Schema

```mermaid
erDiagram
    buckets ||--o{ objects : "has many"

    buckets {
        text id PK
        text name
        text owner_id
        boolean public
        timestamptz created_at
        timestamptz updated_at
        bigint file_size_limit
        text_arr allowed_mime_types
    }

    objects {
        uuid id PK
        text bucket_id FK
        text name
        text owner_id
        timestamptz created_at
        timestamptz updated_at
        timestamptz last_accessed_at
        jsonb metadata
        text_arr path_tokens
        text version
    }

    migrations {
        integer id PK
        varchar_100 name
        varchar_40 hash
        timestamp executed_at
    }
```

Three tables in a `storage` schema. `migrations` is standalone (tracks schema evolution). The core relationship is `buckets` 1-to-many `objects`.

### `buckets`

Top-level containers (like S3 buckets). Stores configuration and constraints.

```sql
CREATE TABLE storage.buckets (
  id          text PRIMARY KEY,
  name        text NOT NULL,
  owner_id    text,
  public      boolean,
  created_at  timestamptz DEFAULT now(),
  updated_at  timestamptz DEFAULT now(),
  file_size_limit    bigint,
  allowed_mime_types  text[]
);

CREATE UNIQUE INDEX bname ON storage.buckets USING BTREE (name);
```

### `objects`

Per-file metadata. One row per file.

```sql
CREATE TABLE storage.objects (
  id               uuid PRIMARY KEY DEFAULT gen_random_uuid(),
  bucket_id        text REFERENCES storage.buckets(id),
  name             text,
  owner_id         text,
  created_at       timestamptz DEFAULT now(),
  updated_at       timestamptz DEFAULT now(),
  last_accessed_at timestamptz DEFAULT now(),
  metadata         jsonb,
  path_tokens      text[],
  version          text
);

CREATE UNIQUE INDEX bucketid_objname ON storage.objects USING BTREE (bucket_id, name);
CREATE INDEX name_prefix_search ON storage.objects (name text_pattern_ops);
```

Relationship: `buckets` 1-to-many `objects` via `bucket_id`.

### Helper Functions

Supabase defines SQL functions to extract path components from the flat `name` field:

- `storage.foldername(name)`: Splits on `/`, returns all parts except the last (the directory path as `text[]`).
- `storage.filename(name)`: Returns the last part after splitting on `/`.
- `storage.extension(name)`: Returns the file extension.
- `storage.search(prefix, bucketname, limits, levels, offsets)`: Lists objects matching a prefix, with pagination and depth control. Simulates directory listing by splitting `name` on `/` at a given level.

## Key Design Decisions

- **Flat namespace, not a tree**: Objects have a flat `name` like `Documents/MyFile.xlsx`. There are no directory rows. Directory structure is derived by splitting the name on `/`. The `path_tokens` column caches this split.
- **Metadata in JSONB**: Extensible per-file metadata without schema changes.
- **RLS (Row Level Security)**: Enabled on the objects table. Access control via Postgres policies, not application-level checks.
- **Unique constraint on (bucket_id, name)**: Prevents duplicate filenames within a bucket.
- **Prefix search index**: `text_pattern_ops` index enables efficient `LIKE 'prefix%'` queries for directory listing.

> The flat namespace approach is simpler than a tree (no parent_id, no recursive queries). The tradeoff: Renaming a folder means updating every object whose `name` starts with that folder prefix.

## Takeaways for Our System

- Flat namespace with `/`-delimited names is a viable approach for our file sizes and counts.
- `path_tokens` (cached split) is a practical optimization for directory listing queries.
- JSONB metadata is flexible but harder to query/index than dedicated columns.
- RLS for access control is worth considering if we use Supabase or raw Postgres.
