---
_type: Experience
_label: "File System on the Web"
status: "active"
---

This folder documents all the research I've conducted to converge on a solution for designing filesystem APIs on dbdocs/dbdiagram. This is to support the multifile DBML feature (which I have shipped in the compiler quite ago) on the cloud.

The compiler intentionally just needs a file system interface to resolve imports, etc. So the task of designing filesystem is quite isolated with the compiler's internals.

[[directory-index]]

## Constraints

- Each user has multiple workspaces, each of which has a logical file system, in which files are stored.
- Each file can have permission settings.
- Almost every files are plain texts, not binary.
- Files can be very large, up to 20k LOC.
- A workspace can have tens or hundreds of files.
- Almost likely, we won't use specialized cloud-based storage solutions like S3, etc. We usually don't want the hussle of contacting devops and allocate more unique resources. Adding more servers is OK though, but need some justifications.
- Shall account for concurrent reads/writes and data consistency.

## Use Cases

- If file A imports file B and a PRO user is viewing file A, a concurrent change to file B should be reflected to that user.

## Articles & References

## Storage

### GitHub

- [How GitHub stores and serves Git repos](https://singhajit.com/how-github-stores-and-serves-git-repositories/): full architecture walkthrough `[file]` `[metadata]`
- [GitHub DGit/Spokes](https://github.blog/engineering/architecture-optimization/introducing-dgit/): distributed Git storage `[file]`
- [Git's database internals](https://github.blog/engineering/architecture-optimization/gits-database-internals-i-packed-object-store/): pack files, object store, content-addressed storage `[file]`
- [GitHub Contents API](https://docs.github.com/en/rest/repos/contents): file CRUD over REST, git-backed. Closest to our use case `[api]`

### GitLab

- [Gitaly](https://docs.gitlab.com/administration/gitaly/): gRPC service wrapping all Git storage access `[file]` `[metadata]`
- [GitLab Repository Files API](https://docs.gitlab.com/ee/api/repository_files.html): similar to GitHub, URL-encoded paths `[api]`

### Gitea

- [Gitea source](https://github.com/go-gitea/gitea): Go, git-on-disk + DB metadata, easy to read `[file]` `[metadata]`

### Supabase

- [Supabase Storage source](https://github.com/supabase/storage): TypeScript, S3+Postgres metadata pattern `[file]` `[metadata]`
- [Supabase storage schema](https://supabase.com/docs/guides/storage/schema/design): buckets + objects tables `[metadata]`
- [Supabase access control via PostgreSQL RLS](https://supabase.com/docs/guides/storage/security/access-control) `[metadata]`
- [Hierarchical RLS challenges](https://supabase.com/docs/guides/troubleshooting/supabase-storage-inefficient-folder-operations-and-hierarchical-rls-challenges-b05a4d): folder-level permissions are hard with RLS `[metadata]`

### Microsoft

- [OneDrive/MS Graph API](https://learn.microsoft.com/en-us/graph/onedrive-addressing-driveitems): hybrid path+ID addressing `[api]`
- [VS Code FileSystemProvider](https://vshaxe.github.io/vscode-extern/vscode/FileSystemProvider.html): cleanest modern FS interface (stat, readFile, writeFile, readDirectory, rename, delete, watch) `[api]`

### General

- [PostgreSQL: storing files in DB](https://wiki.postgresql.org/wiki/BinaryFilesInDB): acceptable for files <100KB, simplified backups `[file]`
- [Database vs blob storage](https://engineeringatscale.substack.com/p/when-to-use-blob-storage-vs-database): decision guide `[file]`
- [Cloud storage HTTP APIs compared](http://lukasmartinelli.ch/cloud/2014/07/21/cloud-storage-apis-compared.html): Dropbox vs Google Drive vs S3 vs Box `[api]`
- [Optimistic locking with ETags](https://sookocheff.com/post/api/optimistic-locking-in-a-rest-api/): the right default for web file APIs `[api]` `[collaboration]`
- [Google Drive/Dropbox system design](https://www.pankajtanwar.in/blog/system-design-how-to-design-google-drive-dropbox-a-cloud-file-storage-service): metadata DB + blob storage split, chunked uploads, sync via message queues `[file]` `[metadata]`

## Realtime & Collaboration

### Figma

- [multiplayer technology](https://www.figma.com/blog/how-figmas-multiplayer-technology-works/) `[collaboration]`
- [multiplayer infrastructure deep dive](https://sujeet.pro/articles/figma-multiplayer-infrastructure) `[collaboration]`
- [S3 checkpointing + DynamoDB WAL for file persistence](https://www.figma.com/blog/making-multiplayer-more-reliable/) `[collaboration]` `[file]`
- [database scaling](https://www.figma.com/blog/how-figma-scaled-to-multiple-databases/) `[collaboration]`

## Out-of-Scope

### Dropbox: Magic Pocket

Out of scope: uses immutable blob store, not applicable to our text file model.

- [storage efficiency in their immutable blob store](https://dropbox.tech/infrastructure/improving-storage-efficiency-in-magic-pocket-our-immutable-blob-store)
- [architecture summary](https://medium.com/@anant7210/dropbox-magic-pocket-5ec95cc40a42)
- [QCon presentation](https://qconsf.com/presentation/oct2022/magic-pocket-dropboxs-exabyte-scale-blob-storage-system)

### Supabase Storage (tool-specific)

Out of scope: too tool-specific, may revisit after research. Supabase Storage is S3-compatible, deployable on a dedicated server without cloud dependency.

- [open source, full implementation (TypeScript, S3+Postgres pattern)](https://github.com/supabase/storage)
- [storage docs](https://supabase.com/docs/guides/storage)
- [schema design](https://supabase.com/docs/guides/storage/schema/design)
