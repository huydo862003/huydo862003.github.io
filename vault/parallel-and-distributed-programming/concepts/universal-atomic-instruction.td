---
_type: ParallelDistProgConcept
_label: 'Universal Atomic Instruction'
journey: fref("parallel-and-distributed-programming/index.td")
status: 'learning'
tags:
  - 'parallel programming'
depends_on:
  - fref("parallel-and-distributed-programming/concepts/atomic-instruction.td")
  - fref("parallel-and-distributed-programming/concepts/consensus-number.td")
---

An atomic instruction is universal if it can implement any concurrent object in a wait-free manner for any number of processes. Equivalently, it has a consensus number of infinity.

Compare-and-Swap (CAS) is the canonical universal atomic instruction. Read/write registers and Fetch-and-Add are not universal: They can only solve consensus for 1 and 2 processes, respectively.
