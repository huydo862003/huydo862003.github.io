## DGit (now Spokes)

https://github.blog/engineering/architecture-optimization/introducing-dgit/

For context:

> GitHub stores 35M+ repos and 30M+ Gists across hundreds of servers.

For high-availability and disaster recovery, GitHub replicates a repo three times. There are some notable points here:

- Github does **NOT** replicate at the **disk layer** (do not dump and store disk images). Instead, it replicates at the **application layer**.
  - A **replica** = 3 loosely coupled Git repos.
  - Replicas are synced via Git protocols.
- When a file server is down, DGit detects which repositories need backup to reach the 3 replica count.

Pros:

- I think that restoring from disk images can be slow and hurt availability, so likely this helps improve high availability. Storing replications as redundant repos can help recovery much faster.
- Recovery is fast according to them, claiming healing throughput to be N^2.

### DGit Uses Plain `git`

DGit stores repos the same way end users do: objects, pack files, and references in a `.git` directory.

> No SAN, no distributed filesystem, no magical cloud abstraction.

Remark: Well this is partly like our constraints.

Their rationales:

- Git is very sensitive to latency. A simple `git log` or `git blame` might load thousands of objects sequentially. Any latency in disk access kills performance. So distributed filesystems are not viable, DGit stores repos on fast, local SSDs.
- At a higher level, Git already has efficient protocols for exchanging updates between repos (pushes, fetches). DGit uses these same protocols to keep replicas in sync.
- Git is mature and well-tested.
- GitHub's philosophy: use Git on servers the same way users use it. When they hit bottlenecks, their core Git/libgit2 contributors fix the issues upstream and contribute back to open source.

::: details What do they mean by "cloud" here?
"Cloud" here refers to the storage layer in Github's POV, not the product. They mean services like S3, NFS, or distributed filesystems (Ceph, GlusterFS) where the disk is accessed over a network.
:::

::: details Isn't GitHub itself a cloud?
Yes, but the distinction is how the disk is attached. GitHub runs Git on dedicated fileservers where the SSD is physically in the same machine. No network hop between the Git process and the disk. GitHub could have attached a cloud storage like S3 to the local FS and runs git on there, but it's slow.
:::

::: details Why is local SSD faster than network storage?
Git's internal operations do many small sequential disk reads (thousands of object lookups). Local SSD: ~0.1ms per read. Network storage: ~1-10ms per read. Over thousands of reads, that difference compounds massively.
:::

::: details Why not just use cloud VMs and run git natively on the cloud there?
That would work fine, as long as the VM has locally attached SSDs (like EC2 with NVMe). The point is: Git process and disk on the same machine.
:::
