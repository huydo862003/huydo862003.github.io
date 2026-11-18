---
_type: schema
_label: "Design Concept"
_icon: icon.lightbulb
_extends: Concept
properties:
  tags:
    type: list['accessibility' | 'affordances' | 'branding' | 'design antipattern' | 'design ops' | 'design pattern' | 'design psychology' | 'design system' | 'design tool' | 'frontend technology' | 'HCI' | 'mental models' | 'UI UX' | 'user-centered design' | 'UX']?
  books:
    type: list[Book]?
    computed: (r) -> vault.from_node(r).follow_back(DesignBook, "concepts").to_list()
  flashcards:
    type: list[Flashcard]?
    computed: (r) -> vault.from_node(r).follow_back(DesignFlashcard, "concepts").to_list()
---
