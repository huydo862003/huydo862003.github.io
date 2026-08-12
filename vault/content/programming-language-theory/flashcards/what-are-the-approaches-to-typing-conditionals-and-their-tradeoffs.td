---
_type: Flashcard
deck: 'type-theory'
books:
  - fref("programming-language-theory/books/programming-languages-application-and-interpretation/chapter-5-types.td")
---

::: flashcard
What are the approaches to typing conditionals and their tradeoffs?
=== key
- 1st approach: True and False branches must be of the same types.

    Pros:

  - Simple to implement and understand.
  - The precise type of the conditionals is mostly unambiguous.

    Cons:

  - Inflexible: Dynamic dispatches are harder to express, for example.
  - Not expressive.
- 2nd approach: The type of the conditionals is the Union type of both branches.

    Pros:

  - More flexible: Each branch can return an arbitrary type.

    Cons:

  - The consumer of the results of conditionals must use some techniques like If-splitting.
- 3rd approach: The type of the conditionals is the least upper bound of both branches.

    Pros:

  - Flexible.

    Cons:

  - The exact typing of each branch is lost.
:::
