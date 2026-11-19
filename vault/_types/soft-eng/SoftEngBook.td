---
_type: schema
_label: "Software Engineering Book"
_icon: icon.book
_extends: Book
properties:
  tags:
    type: list['code analysis' | 'Software design']?
  flashcards:
    type: list[Flashcard]?
    computed: (r) -> vault.from_node(r).follow_back(SoftEngFlashcard, "books").to_list()
---
