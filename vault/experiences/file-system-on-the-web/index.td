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
 : Concurrent reads/writes
 : Data consistency

## Articles & References

Some resources crawled from the web:

### GitHub: DGit/Spokes

- https://github.blog/engineering/architecture-optimization/introducing-dgit/: original announcement of distributed Git storage
- https://singhajit.com/how-github-stores-and-serves-git-repositories/: how GitHub stores and serves Git repos
- https://www.pankajtanwar.in/blog/how-does-github-store-millions-of-repo-and-billions-of-files: good summary post

Out of scope:

- https://github.blog/2017-10-13-stretching-spokes/: cross-datacenter replication -> :cross: Out-of-scope
- https://github.blog/engineering/infrastructure/building-resilience-in-spokes/: replication and fault tolerance -> :cross: Out-of-scope

### GitLab: Gitaly

- https://docs.gitlab.com/development/architecture/: GitLab architecture overview
- https://docs.gitlab.com/administration/gitaly/: Gitaly and Gitaly Cluster docs
- https://www.mulesoft.com/api-university/how-gitlab-puts-grpc-real-world: how GitLab uses gRPC

### Dropbox: Magic Pocket

- https://dropbox.tech/infrastructure/improving-storage-efficiency-in-magic-pocket-our-immutable-blob-store: storage efficiency in their immutable blob store
- https://medium.com/@anant7210/dropbox-magic-pocket-5ec95cc40a42: architecture summary
- https://qconsf.com/presentation/oct2022/magic-pocket-dropboxs-exabyte-scale-blob-storage-system: QCon presentation

### Figma

- https://www.figma.com/blog/how-figmas-multiplayer-technology-works/: multiplayer technology
- https://www.figma.com/blog/making-multiplayer-more-reliable/: S3 checkpointing + DynamoDB WAL for file persistence
- https://sujeet.pro/articles/figma-multiplayer-infrastructure: multiplayer infrastructure deep dive
- https://www.figma.com/blog/how-figma-scaled-to-multiple-databases/: database scaling

### Supabase Storage

- https://github.com/supabase/storage: open source, full implementation (TypeScript, S3+Postgres pattern)
- https://supabase.com/docs/guides/storage: storage docs
- https://supabase.com/docs/guides/storage/schema/design: schema design
- https://supabase.com/docs/guides/storage/security/access-control: access control via PostgreSQL RLS
- https://supabase.com/docs/guides/troubleshooting/supabase-storage-inefficient-folder-operations-and-hierarchical-rls-challenges-b05a4d: hierarchical RLS challenges

### SourceHut

- https://man.sr.ht/git.sr.ht/: git.sr.ht docs
- https://man.sr.ht/ops/scale.md: scalability plans
- https://sourcehut.org/blog/2020-06-10-how-graphql-will-shape-the-alpha/: GraphQL and architecture evolution
- https://github.com/snimmagadda/sourcehut-notes/blob/master/sourcehut.org: architecture notes

### Gitea / Forgejo

- https://github.com/go-gitea/gitea: source code (Go, easy to read)
- https://deepwiki.com/go-gitea/gitea/1.1-architecture-overview: architecture overview
- https://deepwiki.com/go-gitea/gitea/4-repository-management: repository management system
- https://docs.gitea.com/usage/packages/storage/: storage docs

### General

- https://algocademy.com/blog/how-to-design-a-file-storage-system-in-a-system-design-interview/: file storage system design
- https://engineeringatscale.substack.com/p/when-to-use-blob-storage-vs-database: database vs blob storage
- https://wiki.postgresql.org/wiki/BinaryFilesInDB: PostgreSQL wiki on storing files in DB
