---
_type: PltConcept
_label: 'Lexical analysis'
journey: fref("/programming-language-theory/index.td")
status: 'mastered'
books: vault.from_node(self).follow_back(PltBook, "concepts").to_list()
tags:
  - 'compiler implementation'
  - 'linguistics'
  - 'syntax & grammar'
flashcards: vault.from_node(self).follow_back(PltFlashcard, "concepts").to_list()
---

::: info
(Syntax & Grammar, Linguistics) The process of classifying texts into ${fref("/programming-language-theory/concepts/syntactic-category.td")}s.
:::

- Removing comments and whitespaces.
- Categorizing tokens.
