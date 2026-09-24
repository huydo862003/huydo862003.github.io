---
_type: ParallelDistProgConcept
_label: 'Serializability'
journey: fref("parallel-and-distributed-programming/index.td")
status: 'learning'
tags:
  - 'correctness condition'
depends_on:
  - fref("parallel-and-distributed-programming/concepts/correctness-condition.td")
---

A correctness condition for concurrent transactions. A concurrent execution of transactions is serializable if its outcome is equivalent to some serial (one-at-a-time) execution of those transactions.

Serializability is the standard correctness condition in databases. It is weaker than linearizability: It does not require the equivalent serial order to respect real-time ordering of non-overlapping transactions. Strict serializability combines serializability with real-time order, making it equivalent to linearizability at the transaction level.
