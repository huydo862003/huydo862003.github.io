---
_type: ParallelDistProgConcept
_label: 'Progress Guarantee'
journey: fref("parallel-and-distributed-programming/index.td")
status: 'learning'
tags:
  - 'progress guarantee'
---

A property of concurrent algorithms that characterizes how much one process can hinder another from completing its operation. Only relevant in the presence of multiple concurrent processes.

From weakest to strongest: blocking (locks) → lock-free (global progress guaranteed) → wait-free (every live process completes in finite steps).
