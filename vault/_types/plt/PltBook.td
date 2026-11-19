---
_type: schema
_label: "Programming Language Theory Book"
_icon: icon.book
_extends: Book
properties:
  phase:
    type: Phase?
  tags:
    type: list['fundamentals of programming language' | 'lambda calculus' | 'logic' | 'semantics' | 'syntax & grammar' | 'type theory']?
  flashcards:
    type: list[Flashcard]?
    computed: (r) -> vault.from_node(r).follow_back(PltFlashcard, "books").to_list()
---
