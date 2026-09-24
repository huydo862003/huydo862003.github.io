---
_type: ParallelDistProgConcept
_label: "Herlihy's Hierarchy"
journey: fref("parallel-and-distributed-programming/index.td")
status: 'learning'
tags:
  - 'parallel programming'
depends_on:
  - fref("parallel-and-distributed-programming/concepts/consensus-number.td")
---

A classification of synchronization primitives by their consensus number, establishing a strict power hierarchy. A primitive with consensus number n can implement any concurrent object wait-free for up to n processes, but cannot implement consensus for n + 1 or more.

The hierarchy shows that no combination of primitives with consensus number less than n can implement a primitive with consensus number n. This makes consensus number a meaningful measure of synchronization power.

| Consensus Number | Primitives |
|---|---|
| 1 | Read/write registers |
| 2 | Fetch-and-Add, Fetch-and-Set, queue (2 processes) |
| ∞ | Compare-and-Swap, Load-Link/Store-Conditional |
