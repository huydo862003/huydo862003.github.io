---
_type: ParallelDistProgConcept
_label: 'Atomic Instruction'
journey: fref("parallel-and-distributed-programming/index.td")
status: 'learning'
tags:
  - 'parallel programming'
---

A machine-level operation that executes indivisibly. From the perspective of any other thread or process, an atomic instruction either has not started or has fully completed; there is no observable intermediate state.

Atomic instructions are the primitive building blocks for non-blocking concurrent algorithms. Common examples include read, write, Fetch-and-Add, Compare-and-Swap, and Load-Link/Store-Conditional.
