---
_type: ParallelDistProgConcept
_label: 'Synchronizes-With Relationship'
journey: fref("parallel-and-distributed-programming/index.td")
status: 'learning'
tags:
  - 'computation model'
depends_on:
  - fref("parallel-and-distributed-programming/concepts/memory-model.td")
---

A happens-before relationship between operations in different threads. If operation A synchronizes-with operation B, then all memory writes performed before A are guaranteed to be visible to any thread that has observed B.

In C++11, a release store on atomic variable X synchronizes-with any acquire load on X that reads the stored value. This is the primary mechanism for reasoning about inter-thread visibility without requiring sequential consistency.
