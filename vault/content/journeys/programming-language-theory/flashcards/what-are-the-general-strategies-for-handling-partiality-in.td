---
_type: Flashcard
question: "What are the general strategies for handling partiality in type systems?"
deck: 'type-theory'
books:
  - fref("journeys/programming-language-theory/books/programming-languages-application-and-interpretation/chapter-5-types.td")
---

::: flashcard
${question}
=== key
1. Exception
  - Pros: Simple.
  - Cons: Lie about its contract.
2. Option type
  - Pros: Simple & Truthful about contract.
  - Cons: Do not interoperate with legacy systems. Require migration. Caller needs to explicitly handle error case.
3. Refined type
  - Pros: Extremely type-safe and truthful about its contract.
  - Cons: Undecidable.
:::
