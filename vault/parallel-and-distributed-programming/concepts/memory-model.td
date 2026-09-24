---
_type: ParallelDistProgConcept
_label: 'Memory Model'
journey: fref("parallel-and-distributed-programming/index.td")
status: 'learning'
tags:
  - 'computation model'
---

A specification that defines what values a read is allowed to return given a concurrent history of reads and writes. It constrains the valid reorderings of memory operations that hardware and compilers may perform.

The memory model is what makes concurrent reasoning possible: It tells the programmer which optimizations the system may apply and what synchronization is needed to establish guarantees. Examples: The C++11 memory model, the Java memory model, the x86-TSO hardware model.
