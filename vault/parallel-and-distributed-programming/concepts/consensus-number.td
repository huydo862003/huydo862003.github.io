---
_type: ParallelDistProgConcept
_label: 'Consensus Number'
journey: fref("parallel-and-distributed-programming/index.td")
status: 'learning'
tags:
  - 'parallel programming'
depends_on:
  - fref("parallel-and-distributed-programming/concepts/consensus-problem.td")
---

The maximum number of processes for which a given synchronization primitive can solve the consensus problem in a wait-free manner. Defined by Herlihy's hierarchy.

Examples: Read/write registers have consensus number 1. Fetch-and-Add and Fetch-and-Set have consensus number 2. Compare-and-Swap and Load-Link/Store-Conditional have consensus number ∞, making them universal.
