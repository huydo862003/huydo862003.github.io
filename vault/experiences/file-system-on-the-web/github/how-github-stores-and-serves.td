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

