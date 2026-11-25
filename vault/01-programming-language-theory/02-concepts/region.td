---
_type: PltConcept
_label: "PltConcept"
status: "learning"
blocks:
  - fref('./arena-allocator.td')
tags:
  - 'compiler implementation'
---

::: info
(Compiler implementation) Also called a **partition**, **subpool**, **zone**, **${fref("./arena.td")}**, **area**, **memory context**, a collection of allocated objects that can be efficiently reallocated or deallocated all at once. Essentially, the objects in the arena have the same lifetime pattern as the stack variables, but they can live longer than the stack frame in which they were allocated.
:::
