---
_type: SoftEngConcept
_label: 'Eventual Consistency'
journey: fref("software-engineering/index.td")
status: 'learning'
tags:
  - 'architecture'
---

A consistency model where a distributed system guarantees that, if no new updates are made to a given piece of data, all replicas will eventually converge to the same value. There is no guarantee of when convergence happens, only that it will.

Contrasts with strong consistency, where every read reflects the most recent write regardless of which replica serves it.
