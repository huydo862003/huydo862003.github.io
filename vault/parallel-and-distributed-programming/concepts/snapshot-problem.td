---
_type: ParallelDistProgConcept
_label: 'Snapshot Problem'
journey: fref("parallel-and-distributed-programming/index.td")
status: 'learning'
tags:
  - 'distributed systems'
---

The problem of capturing a consistent global state of a distributed system while the system continues to run. Because there is no shared clock and messages are in flight, a naive approach of "read all nodes at the same time" is impossible.

A consistent snapshot must capture a cut across all processes such that if a message receipt is included, the corresponding send is also included. The Chandy-Lamport algorithm solves this by using marker messages to delineate pre-snapshot and post-snapshot events without stopping the system.
