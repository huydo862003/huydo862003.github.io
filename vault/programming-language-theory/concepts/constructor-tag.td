---
_type: Concept
_label: 'Constructor tag'
journey: fref("programming-language-theory/index.td")
status: 'reviewing'
tags:
  - 'language-feature-design'
  - 'runtime'
  - 'type theory'
---

A runtime marker that distinguishes which variant of a ${fref("programming-language-theory/concepts/sum-type.td")} a value belongs to, enabling ${fref("programming-language-theory/concepts/pattern-matching.td")} to dispatch on the correct case. Not to be confused with ${fref("programming-language-theory/concepts/type-variant.td")}s, which are static properties.
