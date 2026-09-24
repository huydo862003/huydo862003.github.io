---
_type: ParallelDistProgConcept
_label: 'Quiescent Consistency'
journey: fref("parallel-and-distributed-programming/index.td")
status: 'learning'
tags:
  - 'correctness condition'
depends_on:
  - fref("parallel-and-distributed-programming/concepts/correctness-condition.td")
---

A correctness condition weaker than sequential consistency. It requires that after any quiescent state (a moment when no operations are in progress), the observable state must be consistent with some legal sequential history of the completed operations.

Unlike linearizability and sequential consistency, quiescent consistency does not constrain the order of operations that overlap in time, only that quiescent points separate them into well-defined epochs. This allows more reordering, making it suitable for high-performance data structures where strict ordering is not needed.
