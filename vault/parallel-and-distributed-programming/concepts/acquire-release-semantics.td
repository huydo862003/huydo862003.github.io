---
_type: ParallelDistProgConcept
_label: 'Acquire-Release Semantics'
journey: fref("parallel-and-distributed-programming/index.td")
status: 'learning'
tags:
  - 'computation model'
depends_on:
  - fref("parallel-and-distributed-programming/concepts/memory-model.td")
  - fref("parallel-and-distributed-programming/concepts/synchronizes-with-relationship.td")
---

A pair of memory ordering constraints used to establish synchronization between threads.

- **Acquire:** No memory operation after this point can be reordered before it. Used on loads (e.g., acquiring a lock, reading a flag).
- **Release:** No memory operation before this point can be reordered after it. Used on stores (e.g., releasing a lock, publishing data).

A release store on variable X that is later observed by an acquire load on X establishes a synchronizes-with relationship: All writes before the release are guaranteed to be visible after the acquire.
