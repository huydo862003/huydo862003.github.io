---
_type: PltConcept
_label: 'Expression problem'
journey: fref("programming-language-theory/index.td")
status: 'learning'
books:
  - fref("programming-language-theory/books/programming-languages-application-and-interpretation/chapter-5-types.td")
---

Neither paradigm naturally supports both dimensions of extensibility without modifying existing code or sacrificing ${fref("programming-language-theory/concepts/type-safety.td")}. Solutions exist (type classes, object algebras, tagless final) but invo

| Approach | Easy to add | Hard to add |
| --- | --- | --- |
| **${fref("programming-language-theory/concepts/algebraic-data-type.td")}s + functions** | New **functions** (just define another) | New **variants** (must edit all existing functions) |
| **OO classes + methods** | New **variants** (just add subclass) | New **operations** (must edit all existing classes) |

Neither paradigm naturally supports **both dimensions** of extensibility without modifying existing code or sacrificing type safety. Solutions exist (type classes, object algebras, tagless final) but involve trade-offs.
