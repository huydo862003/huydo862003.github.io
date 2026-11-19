---
_type: schema
_label: "Design Book"
_icon: icon.book
_extends: Book
properties:
  tags:
    type: list['accessibility' | 'affordances' | 'branding' | 'design antipattern' | 'design ops' | 'design pattern' | 'design psychology' | 'design system' | 'design tool' | 'frontend technology' | 'HCI' | 'mental models' | 'UI UX' | 'user-centered design' | 'UX']?
  flashcards:
    type: list[Flashcard]?
    computed: (r) -> vault.from_node(r).follow_back(DesignFlashcard, "books").to_list()
---
