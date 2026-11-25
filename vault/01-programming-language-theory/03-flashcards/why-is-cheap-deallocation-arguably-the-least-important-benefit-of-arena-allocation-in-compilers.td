---
_type: PltFlashcard
_label: 'Why is cheap deallocation arguably the least important benefit of arena allocation in compilers?'
concepts:
  - fref("/01-programming-language-theory/02-concepts/arena-allocator.td")
  - fref("/01-programming-language-theory/02-concepts/region-based-memory-management.td")
tags:
  - 'compiler implementation'
---

::: flashcard{deck="Data-Oriented Parsing"}
Why is cheap deallocation arguably the least important benefit of arena allocation in compilers?
=== key
ASTs tend to persist all the way to the end of compilation, so you might not need to free them at all. The other benefits (locality, smaller references, cheap allocation) matter more in practice.
:::
