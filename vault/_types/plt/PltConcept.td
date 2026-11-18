---
_type: schema
_label: "Programming Language Theory Concept"
_icon: icon.lightbulb
_extends: Concept
properties:
  phase:
    type: Phase?
  tags:
    type: list['compiler implementation' | 'computation theory' | 'concurrency theory' | 'data structure & algorithm' | 'design principle' | 'domain theory' | 'formal system' | 'lambda calculus' | 'language feature/design' | 'linguistics' | 'logic' | 'metaprogramming/self-reflection' | 'order & lattice theory' | 'other mathematics' | 'program analysis' | 'programming paradigm' | 'proof/reason technique' | 'runtime' | 'semantics' | 'set theory & relation' | 'syntax & grammar' | 'type theory']?
  books:
    type: list[Book]?
    computed: (r) -> vault.from_node(r).follow_back(PltBook, "concepts").to_list()
  flashcards:
    type: list[Flashcard]?
    computed: (r) -> vault.from_node(r).follow_back(PltFlashcard, "concepts").to_list()
---
