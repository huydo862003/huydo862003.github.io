Link: https://github.blog/engineering/architecture-optimization/introducing-dgit/

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

## DGit Uses Plain `git`

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

## GitHub Archictecture Before DGit

_Picture from GitHub blog_

![fileservers](_assets/fileservers.webp)

Previously, repositories were replicated using **disk-layer replication** (RAID and [DRBD](https://linbit.com/downloads/)) with a somewhat old-school HA scheme:

1. File servers are orgarnized in pairs.
2. Each **active file server** has a cross-over cable that connects directly to a dedicated **online** spare.
3. Each disk has 4 copies:
   - 2 on the main file server using RAID.
   - 2 on the hot spare, using DRBD.

Failover strategy:

1. A file server crashed.
2. A human would confirm the fault before making the spare take over.

-> This takes time and causes downtime.
-> GitHub decided to always store repositories on specialized, reliable servers.

::: details What is a cross cable?

A cross-over cable is a direct Ethernet cable connecting two machines to each
other, bypassing any switch or router. So the setup was:

[Active fileserver] ---cross-over cable--- [Spare fileserver]

DRBD replicates disk writes over that direct cable in real-time. Every write to the active server's disk gets mirrored to the spare's disk. If the active dies, the spare has an identical disk image and can take over.
:::

## GitHub Architecture After DGit

_Picture from GitHub blog_

![architecture](_assets/architecture.webp)

File servers are pooled into a cluster called `github-dfs` ("DGit file server").

1. Each repo is stored on 3 servers, chosen independently and distributed across the pool.
2. DGit automatically selects which servers host each repo, keeps replicas in sync, and picks the best server for reads.
3. Writes are synchronously streamed to all 3 replicas, only committed if at least 2 confirm success.
4. Repos are stored on local disks, served by Git and libgit2. Clients: the web frontend and proxies that speak to users' Git clients.

::: details The above paragraph implies Github maintain servers closely to each other? Does GitHub have distributed data centers?
Yes. The "Stretching Spokes" blog post (2017) covers this. They extended Spokes to replicate across multiple data centers for disaster recovery. Before that, all three replicas lived in the same data center.
:::

## Benefits of DGit (Compared to Before)

- No more paired servers. File servers can be a heterogeneous pool in whatever spatial configuration.
- Server failure is less urgent.
  - In the old setup: if one server died, its spare ran with no backup, and a two-server outage could take hundreds of thousands of repos offline.
  - DGit: quickly makes new copies and distributes them across the cluster.
- Routing around failure is less disruptive.
  - Just stop routing traffic to a failed server until it recovers.
  - No reboot/resync needed.
  - Safe to reboot production servers with no transition period. No need for human confirmation of outages.
- No idle hot spares.
  - Every CPU and all memory handles user traffic.
  - Reads (which far outnumber writes) can be served from any replica, so each repo handles ~3x the traffic.
  - CPU load on DGit servers is roughly 2-3x lower than the old setup.
- Automatic balancing.
  - Adding servers requires no planning.
  - DGit moves repos at random to new servers until disk/CPU are balanced.
  - As repos grow/shrink or change popularity, DGit rebalances automatically.
- Less fate sharing.
  - Previously, repos on the same server suffered together if one was too big/popular.
  - With DGit, other repos can be served from their other replicas, which are unlikely to share the same servers.
- Replicas can be placed in different availability zones or data centers, improving availability and enabling geo-local serving.

## Tradeoffs of DGit

The biggest complexity: replication is no longer transparent.

- With DRBD, the hot spare was automatically synced at the disk layer.
- With DGit, replication is explicit (3 servers per repo), so DGit must implement its own serializability, locking, failure detection, and resynchronization.

## Takeaways for Our System

- If we decide to run `git` on our server to offer version control, should run `git` locally on local disk.
- One possible approach is to store git repos on our server.
- This post does not cover locking, serializability, etc. though. Replication is important but not really relevant here.
