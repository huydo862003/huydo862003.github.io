---
_type: ParallelDistProgConcept
_label: 'Sequential Consistency'
journey: fref("parallel-and-distributed-programming/index.td")
status: 'learning'
tags:
  - 'computation model'
  - 'correctness condition'
depends_on:
  - fref("parallel-and-distributed-programming/concepts/memory-model.td")
---

A memory consistency model where the result of any execution is the same as if all operations of all processes were executed in some total sequential order, and the operations of each individual process appear in this order in their program order.

Stronger than relaxed consistency models but weaker than linearizability: Sequential consistency does not require the total order to respect real-time order between non-overlapping operations across processes.
