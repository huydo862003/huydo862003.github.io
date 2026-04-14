---
published: true
author: hdnax
createdAt: "2026-03-28"
updatedAt: "2026-03-28"
question: To which degree can type systems catch bad behaviors?
answer: TODO
deck: type-theory
concepts: []
books:
  - chapter-1-introduction
tags: []
keywords:
  - "program"
  - "type"
  - "system"
  - "sound"
  - "prove"
  - "bad"
---


Generally, a sound type system can prove the absence of certain bad behaviors, but may not always prove the presence of certain bad behaviors.

Why?

- If a sound type system aims to prove the presence of certain bad behaviors:
    - If it succeeds in proving so, then it would know that the program should be rejected.
    - But if it fails to prove so, it cannot always accept that program, because it cannot know whether the program indeed does not have any bad behaviors. → A sound type system would have to conservatively reject the program in this case.
    
    → In summary, it cannot accept any programs  Useless.
    
- If a sound type system aims to prove the absence of certain bad behaviors:
    - If it succeeds in proving so, then it would know that it's safe to accept the program.
    - But if it fails to prove so, it can only know that the program may or may not be safe to accept. → A sound type system would have to conservatively reject the program in this case. → A type system in this case is incomplete.
    
    → In summary, a sound type system can reliably accept a good program.
