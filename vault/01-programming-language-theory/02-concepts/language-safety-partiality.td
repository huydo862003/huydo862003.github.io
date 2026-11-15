---
_type: PltConcept
_label: 'Language safety partiality'
journey: fref("/01-programming-language-theory/index.td")
status: 'learning'
flashcards: vault.from_node(self).follow_back(PltFlashcard, "concepts").to_list()
---

According to Types and programming languages, a language that protects its own abstraction, that is, it is mostly impossible to corrupt the run-time’s data structure and program’s data structure (although there can be escape hatches to perform unsafe operations).

According to Types and programming languages, from the view of portability, a language whose behavior can be entirely determined by its programmer’s manual, that is, it is not subject to the internals of the specific machine it runs on.

According to “Type system” [Luca Cardelli, 1996], a language with no untrapped runtime errors at runtime.

According to Programming languages: Application and Interpretation, a language with partial operations and reported safety violations.
