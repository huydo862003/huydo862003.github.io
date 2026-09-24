---
_type: ParallelDistProgConcept
_label: 'Load-Link / Store-Conditional'
journey: fref("parallel-and-distributed-programming/index.td")
status: 'learning'
tags:
  - 'parallel programming'
depends_on:
  - fref("parallel-and-distributed-programming/concepts/atomic-instruction.td")
  - fref("parallel-and-distributed-programming/concepts/consensus-number.td")
---

A pair of atomic instructions. Load-Link (LL) reads a value from a memory location and reserves it. Store-Conditional (SC) writes a new value only if no other process has written to that location since the LL; otherwise it fails.

LL/SC has consensus number ∞ and is equivalent in power to CAS. Unlike CAS, it is naturally immune to the ABA problem because SC fails on any write, not just a value change. Practically, SC can fail spuriously (e.g., due to cache line eviction or context switch). Not supported in MPI-3; CAS is used instead.
