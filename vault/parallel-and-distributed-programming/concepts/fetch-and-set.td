---
_type: ParallelDistProgConcept
_label: 'Fetch-and-Set'
journey: fref("parallel-and-distributed-programming/index.td")
status: 'learning'
tags:
  - 'parallel programming'
depends_on:
  - fref("parallel-and-distributed-programming/concepts/atomic-instruction.td")
  - fref("parallel-and-distributed-programming/concepts/consensus-number.td")
---

An atomic instruction that writes a new value to a memory location and returns the old value, in one indivisible step. Also known as atomic swap or exchange. When the written value is always 1 (true), the specialized form is called Test-and-Set.

Fetch-and-Set has a consensus number of 2: It can solve wait-free consensus for two processes but not three or more.
