---
_type: ParallelDistProgConcept
_label: 'Relaxed Consistency'
journey: fref("parallel-and-distributed-programming/index.td")
status: 'learning'
tags:
  - 'computation model'
  - 'correctness condition'
depends_on:
  - fref("parallel-and-distributed-programming/concepts/memory-model.td")
---

A family of memory consistency models weaker than sequential consistency. They permit the hardware or compiler to reorder memory operations (reads and writes) across threads as long as the program order within each thread is preserved for dependent operations.

Used in practice because enforcing sequential consistency requires expensive synchronization barriers. Examples: processor consistency, release consistency, and the C++11 `memory_order_relaxed` ordering. Stronger consistency is achieved on demand via acquire/release semantics or sequentially-consistent atomic operations.
