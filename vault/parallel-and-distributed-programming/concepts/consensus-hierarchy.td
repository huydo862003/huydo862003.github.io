---
_type: ParallelDistProgConcept
_label: 'Consensus Hierarchy'
journey: fref("parallel-and-distributed-programming/index.td")
status: 'learning'
tags:
  - 'parallel programming'
depends_on:
  - fref("parallel-and-distributed-programming/concepts/herlihy-hierarchy.td")
---

Another name for Herlihy's hierarchy: The ranking of synchronization primitives by their consensus number, showing which primitives can solve consensus (and thus implement any concurrent object wait-free) for how many processes.
