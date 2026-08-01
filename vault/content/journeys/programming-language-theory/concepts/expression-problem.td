---
_type: Concept
title: 'Expression problem'
journey: fref("journeys/programming-language-theory/index.td")
status: 'learning'
books:
  - fref("journeys/programming-language-theory/books/programming-languages-application-and-interpretation/chapter-5-types.td")
---

Neither paradigm naturally supports both dimensions of extensibility without modifying existing code or sacrificing ${fref("journeys/programming-language-theory/concepts/type-safety.td")}. Solutions exist (type classes, object algebras, tagless final) but invo

| Approach | Easy to add | Hard to add |
| --- | --- | --- |
| **${fref("journeys/programming-language-theory/concepts/algebraic-data-type.td")}s + functions** | New **functions** (just define another) | New **variants** (must edit all existing functions) |
| **OO classes + methods** | New **variants** (just add subclass) | New **operations** (must edit all existing classes) |

Neither paradigm naturally supports **both dimensions** of extensibility without modifying existing code or sacrificing type safety. Solutions exist (type classes, object algebras, tagless final) but involve trade-offs.
