
This folder documents all the research I've conducted to converge on a solution for designing filesystem APIs on dbdocs/dbdiagram. This is to support the multifile DBML feature (which I have shipped in the compiler quite ago) on the cloud.

The compiler intentionally just needs a file system interface to resolve imports, etc. So the task of designing filesystem is quite isolated with the compiler's internals.

[[directory-index]]

There are a few constraints our systems have:

- Each user has multiple workspaces, each of which has a logical file system, in which files are stored.
- Each file can have permission settings.
- Almost every files are plain texts, not binary.
- Files can be very large, up to 20k LOC.
- A workspace can have tens or hundreds of files.
- Almost likely, we won't use specialized cloud-based storage solutions like S3, etc. We usually don't want the hussle of contacting devops and allocate more unique resources. Adding more servers is OK though, but need some justifications.
- Shall account for:
  - Concurrent reads/writes
  - Data consistency

## Articles & References

### API Design

How to shape the REST API for file/folder CRUD:

- [GitHub Contents API](https://docs.github.com/en/rest/repos/contents): file CRUD over REST, git-backed. Closest to our use case.
- [GitLab Repository Files API](https://docs.gitlab.com/ee/api/repository_files.html): similar, URL-encoded paths
- [OneDrive/MS Graph API](https://learn.microsoft.com/en-us/graph/onedrive-addressing-driveitems): hybrid path+ID addressing (worth studying the tradeoff)
- [Cloud storage HTTP APIs compared](http://lukasmartinelli.ch/cloud/2014/07/21/cloud-storage-apis-compared.html): Dropbox vs Google Drive vs S3 vs Box
- [VS Code FileSystemProvider](https://vshaxe.github.io/vscode-extern/vscode/FileSystemProvider.html): cleanest modern FS interface (stat, readFile, writeFile, readDirectory, rename, delete, watch)

### System Design

How real services architect file storage:

- [How GitHub stores and serves Git repos](https://singhajit.com/how-github-stores-and-serves-git-repositories/): IMPORTANT, full architecture walkthrough
- [GitHub DGit/Spokes](https://github.blog/engineering/architecture-optimization/introducing-dgit/): distributed Git storage
- [Gitaly](https://docs.gitlab.com/administration/gitaly/): GitLab's gRPC service wrapping all Git storage access
- [Google Drive/Dropbox system design](https://www.pankajtanwar.in/blog/system-design-how-to-design-google-drive-dropbox-a-cloud-file-storage-service): metadata DB + blob storage split, chunked uploads, sync via message queues
- [Gitea source](https://github.com/go-gitea/gitea): Go, git-on-disk + DB metadata, easy to read

### Storage Design

DB vs filesystem vs git:

- [PostgreSQL: storing files in DB](https://wiki.postgresql.org/wiki/BinaryFilesInDB): acceptable for files <100KB, simplified backups
- [Database vs blob storage](https://engineeringatscale.substack.com/p/when-to-use-blob-storage-vs-database): decision guide
- [Supabase Storage source](https://github.com/supabase/storage): TypeScript, S3+Postgres metadata pattern
- [Supabase storage schema](https://supabase.com/docs/guides/storage/schema/design): buckets + objects tables

### Concurrency & Versioning

- [Optimistic locking with ETags](https://sookocheff.com/post/api/optimistic-locking-in-a-rest-api/): the right default for web file APIs
- [Git's database internals](https://github.blog/engineering/architecture-optimization/gits-database-internals-i-packed-object-store/): pack files, object store, content-addressed storage

### Permissions

- [Supabase access control via PostgreSQL RLS](https://supabase.com/docs/guides/storage/security/access-control)
- [Hierarchical RLS challenges](https://supabase.com/docs/guides/troubleshooting/supabase-storage-inefficient-folder-operations-and-hierarchical-rls-challenges-b05a4d): folder-level permissions are hard with RLS

## Out-of-Scope

### Dropbox: Magic Pocket

Out of scope: Dropbox uses immutable blob store

- [storage efficiency in their immutable blob store](https://dropbox.tech/infrastructure/improving-storage-efficiency-in-magic-pocket-our-immutable-blob-store)
- [architecture summary](https://medium.com/@anant7210/dropbox-magic-pocket-5ec95cc40a42)
- [QCon presentation](https://qconsf.com/presentation/oct2022/magic-pocket-dropboxs-exabyte-scale-blob-storage-system)

### Figma: Multiplayer

Multiplayer is the feature of Figma that allows for real-time collaboration.

Out of scope: I'm focusing more on the multifile storage/retrieval, the collaboration feature is already there for a single document.

Intro:

- [multiplayer technology](https://www.figma.com/blog/how-figmas-multiplayer-technology-works/)

Deep dive:

- [multiplayer infrastructure deep dive](https://sujeet.pro/articles/figma-multiplayer-infrastructure)
- [S3 checkpointing + DynamoDB WAL for file persistence](https://www.figma.com/blog/making-multiplayer-more-reliable/)

Scaling:

- [database scaling](https://www.figma.com/blog/how-figma-scaled-to-multiple-databases/)

### Supabase Storage

Supabase storage is an open-source, S3-compatible object storage service to **store and serve** files. It does serve our model well using file buckets.

- Bucket: Like dbdiagram workspace.
- Folder
- File

The API is kind of like this:

```js
const { data, error } = await supabase
  .storage
  .from('documents')
  .list('folder/subfolder', { // Leave empty '' for the root directory
    limit: 100,
    offset: 0,
    sortBy: { column: 'name', order: 'asc' }
  })
```

It has API for querying files/folders. It can be deployed on a dedicated storage server, no need to be cloud-based.

Out of scope: This is too tool-specific, I'm researching storage mechanism. May consider after conducting research.

- [open source, full implementation (TypeScript, S3+Postgres pattern)](https://github.com/supabase/storage)
- [storage docs](https://supabase.com/docs/guides/storage)
- [schema design](https://supabase.com/docs/guides/storage/schema/design)
- [access control via PostgreSQL RLS](https://supabase.com/docs/guides/storage/security/access-control)
- [hierarchical RLS challenges](https://supabase.com/docs/guides/troubleshooting/supabase-storage-inefficient-folder-operations-and-hierarchical-rls-challenges-b05a4d)
