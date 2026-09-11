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

_Image from the website_
${fref('./_assets/git-objects.png')}

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

### Loose Objects & Pack Files

What happens physically when a new object is created?

#### Loose Objects

On each new commit, Git stores every new object as a **loose object**, a single zlib-compressed file under `.git/objects/ab/cdef...` (the first two hex chars form the directory name).

::: details Why do the first two hex chars form a directory?
Many filesystems (especially older ones like ext3) slow down when a single directory has too many entries, because lookups become linear scans. Splitting into 256 subdirectories (`00/` through `ff/`) keeps files per directory manageable. Nginx does the same thing with its proxy cache.
:::

- Pros: Straightforward.
- Cons: Doesn't scale well. At millions of objects, you end up with millions of tiny files on disk.

-> Git will periodically pack loose objects into **pack files**.

#### Pack Files

So, periodically (or on `git gc`), Git rolls many loose objects into a single `pack-<sha>.pack` file, with a companion `pack-<sha>.idx` index.

- Inside a pack, similar objects are stored as **deltas** against each other.
- The index is a sorted list of object IDs and offsets, so `git cat-file` can find any object in `O(log n)` (disk operations?) without scanning the file. Much like a B-tree index in a database.

### References Are Just Files

A branch in Git is just a single text file containing one **40-character commit hash**:

```
$ cat .git/refs/heads/main
9f9258a8ffe4187f08a93bcba47784e07985d999
```

`git push origin main` is, at heart, a request to update one such file on the server. Creating a branch is essentially free.

When the number of refs grows into the hundreds of thousands, individual ref files and the `packed-refs` blob both become a bottleneck. The new **reftable** format fixes this.

## Spokes (DGit): The Storage With Git-on-local-SSD

_Image from the site_

${fref('./_assets/spoke-tier.png')}

Spokes does three jobs:

- Decide repo storage to 3 fileservers.
- Sync the 3 replicas on push.
- Auto-heal when 1 file server fail.

Some notes:

- Spokes is NOT a filesystem or storage engine. It's a coordination layer that sits above plain Git on local SSDs. Each replica is just a normal Git repo.
- Why not abstract the storage? Because Git does thousands of sequential small reads per operation. Even 1ms extra latency per read (from network storage) compounds into seconds. So, keep the disk local.
- No two replicas share a rack. A rack = an availability zone (one power/network failure can kill a whole rack).
- Later, [Stretching Spokes](https://github.blog/2017-10-13-stretching-spokes/) placed replicas across continents. So a clone in Singapore hits a fileserver in Singapore, even if the write originated in Virginia.

::: details Why three replicas?
Three is the smallest number that supports majority voting:

- 1 replica: no redundancy.
- 2 replicas: no quorum if both fail.
- 3 replicas: tolerate 1 failure, still have a majority of 2.
:::

Spokes requires **at least 2 of 3 to confirm a write** before telling the user **the push succeeded**. This gives:

- **Durability**: the write is on 2 disks before acknowledgment.
- **Conflict resolution**: two concurrent pushes can't both acquire a majority of locks, so one waits.

If 2 servers fail, repos are still readable from the remaining replica, but writes are blocked until repair finishes. This is the CAP tradeoff Spokes makes: consistency + partition tolerance over write availability during degraded state. Same tradeoff as Paxos and other majority quorum protocols.

### Writes: 3-Phase Commit

_Image from the site_

${fref('./_assets/spoke-push.png')}

What happens on a `git push`:

1. The proxy opens a `git receive-pack` stream and forwards pack data to **all 3 replicas in parallel**.
2. Phase 1 - **Prepare**: each replica acquires local Git ref locks, verifies old ref values match what the client expects.
3. Phase 2 - **Commit**: majority confirms it can apply. Each agreeing replica writes new refs atomically via `git update-ref --stdin` (a transactional API that GitHub contributed upstream specifically for this).
4. Phase 3 - **Finalize**: committed replicas release locks. A Spokes checksum is computed across the new ref state. If the majority's checksums match, push is acknowledged.
5. Any disagreeing replica gets rolled back and marked unhealthy. A repair job copies missing objects/refs from a healthy replica.

::: details How fast is this across continents?
A round trip across a continent takes 60-80ms. Spokes uses ~4 round trips per write, so a coast-to-coast push of a single ref takes about a third of a second in pure network time. Everything else (checksums, scanning refs, locking) has to run in parallel with the network waits. The [Stretching Spokes](https://github.blog/2017-10-13-stretching-spokes/) post walks through the optimizations.
:::
