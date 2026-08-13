---
_type: Concept
_label: 'Judgment'
title: 'Judgment'
journey: fref("programming-language-theory/index.td")
status: 'reviewing'
books:
  - fref("programming-language-theory/books/programming-languages-application-and-interpretation/chapter-5-types.td")
  - fref("programming-language-theory/books/software-foundations/chapter-2-inductive-definitions.td")
  - fref("programming-language-theory/books/software-foundations/chapter-3-hypothetical-and-general-judgments.td")
tags:
  - 'logic'
---

::: info
(Logic) The mental act of affirming or denying a ${fref("programming-language-theory/concepts/proposition.td")} is true.
:::

- Differences from Propositions
  - **Content vs Act**
    - **Proposition (Content):** A proposition is the objective meaning or information contained in a sentence. It is a claim about the world that *can* be either true or false, but it doesn't necessarily "care" which one it is. It is like a "thought" that exists independently of whether someone believes it.
    - **Judgment (Act):** A judgment is the mental act of **affirming or denying** that a proposition is true. It is the step you take when you look at a proposition and decide to "stamp" it as true or false.
  - Metalanguage vs. object Language In modern logic, this is often explained using "levels" of language:
    - **Propositions** belong to the **${fref("programming-language-theory/concepts/object-language.td")}** (the stuff we are talking about), like $A \lor B$.
    - **Judgments** belong to the **${fref("programming-language-theory/concepts/metalanguage.td")}** (the language we use to talk *about* the logic).

            *Example:* If "It is raining" is the **proposition**, then saying "It is true that 'It is raining'" is the **judgment**.
