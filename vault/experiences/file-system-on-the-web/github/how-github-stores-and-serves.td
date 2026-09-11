---
_label: "How GitHub Stores and Serves Git Repositories"
---

Link: https://singhajit.com/how-github-stores-and-serves-git-repositories/

GitHub is:

- **Plain Git** on local SSDs (Git is disk-latency-sensitive because it performs thousands of sequential object reads per operation)
- **A small distributed systems protocol**: Spokes replication (3 copies per repo, synced via Git protocols).
- A **routing proxy** that picks which Spokes replica to hit.
- **MySQL** for metadata (permissions, branch protection, PR state, etc.)

Knowing this explains why `git push --force` to a busy repo can lag, why clones from far away are still fast, why GitHub can reboot half its fleet unnoticed, and why massive monorepos still respond in under a second.

The article goes bottom-up:

1. Git on disk
2. Spokes (replication)
3. The routing proxy
4. Metadata layer (MySQL)
5. Monorepo optimizations

A GitHub architecture overview from the website:

${fref('./_assets/github-repo-serving-architecture.png')}

From the picture, I can see several important details:

- Large objects use specialized storage: LFS Object Storage. -> Not of our concern now.
- 4 main components:
  - Edges: All the routing/load balancing to the appropriate API server.
  - Application: Auth + Query metadata + Proxy to the appropriate fileservers.
  - Storage (Spokes): Bare Git-on-SSG Replication happens here.
  - Metadata: MySQL + Vitess for storing things like permissions, etc.

## Git on Disk

This section walks through the basic of how Git structures a repo on disk.

The entire **Git database** is stored in the `.git` folder (the below snippet is taken from the site):

```
.git/
  objects/        the object store (the database)
  refs/           branches, tags, remote pointers
  HEAD            which ref is currently checked out
  config          local config
  packed-refs     packed reference list
```

### The `git` Object Store

- The `git` database is also known as the `git` **object store**.
- The `git` object store is a **content-addressable database**: A content addressable database identifies an object by its content, usually implemented by a **hash** of the content.
- The `git` object store stores various **objects**, which fall into 4 types:
  - `blob` objects: Representing file contents (not including metadata like name or mode). Physically, the content bytes of a file is stored in this object.
  - `tree` objects: Representing a directory listing of:
    - File names.
    - File modes.
    - Child object ids (`blob` ids or sub-`tree`).
  - `commit` objects: Representing a commit, containing:
    - Commit message.
    - Commit parents.
    - Commit author.
    - Snapshot pointer to the objects.
  - `tag` objects: Representing a signed pointer to another object + a message.
