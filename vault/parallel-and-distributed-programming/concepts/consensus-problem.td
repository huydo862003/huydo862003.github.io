---
_type: ParallelDistProgConcept
_label: 'Consensus Problem'
journey: fref("parallel-and-distributed-programming/index.td")
status: 'learning'
tags:
  - 'parallel programming'
  - 'distributed systems'
---

A fundamental problem in concurrent and distributed computing where n processes each propose a value and must all agree on a single decided value. A correct consensus protocol satisfies three properties:

- **Agreement:** All processes that decide, decide the same value.
- **Validity:** The decided value was proposed by some process (no value appears from thin air).
- **Termination:** Every non-faulty process eventually decides.

The consensus problem is central to the theory of concurrent objects because it determines which synchronization primitives can implement which objects wait-free.
