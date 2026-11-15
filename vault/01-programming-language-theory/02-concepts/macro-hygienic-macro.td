---
_type: PltConcept
_label: 'Macro hygienic macro'
journey: fref("/01-programming-language-theory/index.td")
status: 'learning'
flashcards: vault.from_node(self).follow_back(PltFlashcard, "concepts").to_list()
---

A ${fref("/01-programming-language-theory/02-concepts/macro-system.td")} that automatically renames variables to prevent accidental ${fref("/01-programming-language-theory/02-concepts/variable-capture.td")}, ensuring that identifiers introduced by the macro don't clash with identifiers at the call site.

Hygienic macros are analogous to ${fref("/01-programming-language-theory/02-concepts/lexical-static-scope.td")} for Macros: Macro variables are not just names, but rather binding information records.
