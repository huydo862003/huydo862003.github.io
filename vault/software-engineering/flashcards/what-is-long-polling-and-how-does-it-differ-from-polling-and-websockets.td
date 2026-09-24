---
_type: SoftEngFlashcard
_label: 'What is long polling and how does it differ from polling and WebSockets?'
deck: 'collaboration'
concepts:
  - fref("software-engineering/concepts/long-polling.td")
---

::: flashcard
What is long polling and how does it differ from polling and WebSockets?
=== key
Polling: Client periodically asks for updates (mostly empty responses, wastes bandwidth). Long polling: Server holds the connection open until it has data to send (efficient but holds one connection per client). WebSockets: Persistent bidirectional connection (lowest per-message overhead, most complex to implement).
:::
