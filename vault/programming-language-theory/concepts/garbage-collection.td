---
_type: Concept
_label: 'Garbage collection'
journey: fref("programming-language-theory/index.td")
status: 'learning'
books:
  - fref("programming-language-theory/books/programming-languages-application-and-interpretation/chapter-1-learning-smol-standard-model-of-languages.td")
---

An ${fref("programming-language-theory/concepts/automatic-memory-management.td")} technique that identifies and reclaims ${fref("programming-language-theory/concepts/heap.td")}-allocated memory no longer reachable by the program, freeing the programmer from explicit deallocation and preventing memory leaks and dangling references.
