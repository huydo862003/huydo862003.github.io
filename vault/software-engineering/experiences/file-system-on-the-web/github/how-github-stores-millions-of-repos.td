---
_label: "How GitHub Stores Millions of Repos and Billions of Files"
---

Link: https://www.pankajtanwar.in/blog/how-does-github-store-millions-of-repo-and-billions-of-files

## Request Flow (Read Path)

What happens when you visit `https://github.com/github/docs`:

```
Browser (github.com/github/docs)
  -> DNS resolution
  -> Load Balancer (picks a "frontend" server)
  |
  |  "Frontend" server (not frontend in the web sense, just the first
  |   layer facing the user. It's a bare metal box: 8-core, 16GB RAM)
  |
  -> Nginx (reverse proxy, TLS termination, static assets)
  -> Unix Domain Socket (local IPC, no TCP overhead)
  -> Unicorn worker (1 of 16 pre-forked Rails processes)
  -> Rails app
      |
      |-- cache hit? -> return immediately (memcached: rendered HTML, git objects)
      |
      |-- cache miss:
          -> Grit (GitHub's Ruby library for git operations,
          |        abstracts away everything below this line)
          -> RPC to Smoke service
              |
              |  Smoke = transparent proxy between Rails and fileservers.
              |  It doesn't know git internals, just pipes connections.
              |
              -> Chimney (library inside Smoke, answers "which fileserver?")
              -> Chimney queries Redis (caches MySQL metadata: repo ID -> fileserver)
              -> Smoke opens connection to the correct fileserver
                  |
                  |  Fileserver = a Spokes node. Bare metal + local SSD.
                  |  Runs plain git. Spokes handles replica coordination.
                  |
                  -> git operation runs locally on SSD
                  -> response back: fileserver -> Smoke -> Grit -> Rails -> Nginx -> client
                     (response bypasses load balancer)
```

::: details What is a "frontend" server here?
Not frontend in the web sense (browser/UI). It means the first layer of servers facing the user. It runs Nginx + Rails. More like "application server" in modern terminology.
:::

::: details Why Unix Domain Socket?
Nginx and Unicorn run on the same machine. UDS is IPC (inter-process communication) through a file on disk, not TCP. Faster than `localhost:3000` because it skips the entire TCP/IP stack.
:::

::: details What exactly is cached?
Rendered page fragments, API responses, git object lookups. If someone already viewed `github/docs` recently, the rendered HTML or git tree data is in cache (likely memcached). No need to hit the fileserver.
:::

::: details What is Grit?
GitHub's Ruby library for interacting with Git repos. An abstraction so Rails can say `repo.tree("main")` without knowing about Smoke, Chimney, or fileservers. It doesn't access the filesystem directly, it makes RPCs to Smoke.
:::

::: details What is Smoke?
A proxy service between the Rails app and the fileservers. It doesn't know git internals. It just opens a connection to the right fileserver and pipes data back and forth ("transparent proxy").
:::

::: details What is Chimney?
A library inside Smoke that answers one question: "which fileserver holds this repo?" It queries Redis (which caches the MySQL metadata). Chimney = routing lookup, Smoke = proxy connection.
:::

::: details Where are Spokes and fileservers in this picture?
The fileserver IS a Spokes node. When Smoke proxies to a fileserver, it's connecting to a machine running Spokes + Git on local SSDs. For reads, Spokes just serves from one replica (no voting). For writes, Spokes coordinates the 3-phase commit across replicas.
:::

::: details Does Smoke query MySQL directly?
No. Chimney queries Redis, which caches MySQL data. MySQL is the source of truth for repo metadata (repo ID -> fileserver mapping), but it's not in the hot path. Rails talks to MySQL directly for other things (auth, permissions, PRs, issues), but that's a separate path.
:::
