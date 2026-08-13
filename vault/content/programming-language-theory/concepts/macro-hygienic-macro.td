---
_type: Concept
_label: 'Macro hygienic macro'
journey: fref("programming-language-theory/index.td")
status: 'learning'
---

A ${fref("programming-language-theory/concepts/macro-system.td")} that automatically renames variables to prevent accidental ${fref("programming-language-theory/concepts/variable-capture.td")}, ensuring that identifiers introduced by the macro don't clash with identifiers at the call site.

Hygienic macros are analogous to ${fref("programming-language-theory/concepts/lexical-static-scope.td")} for Macros: Macro variables are not just names, but rather binding information records.
