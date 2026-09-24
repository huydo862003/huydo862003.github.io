---
_type: SoftEngConcept
_label: 'Operational Transformation'
journey: fref("software-engineering/index.td")
status: 'learning'
tags:
  - 'collaboration'
---

A technique for resolving conflicts in collaborative text editing. Defines operations through offsets in text (insert at position N, delete at position M). A central server transforms concurrent operations against each other so both can be applied.

## How It Works

- Each edit is an operation with a type (insert/delete) and a position offset.
- When two clients edit concurrently, the server transforms one operation's positions against the other.
- This ensures both operations can be applied in any order and produce the same result.

## Strengths

- Low memory and performance overhead for long text documents.
- Well-studied, most well-known technique for collaborative editing.
- Powers Google Docs and most collaborative text apps.

## Weaknesses

- Extremely hard to implement correctly.
- Operations propagate with finite speed, so participants have different states. The resulting combinations are hard to foresee.
- Causes a combinatorial explosion of possible states.
- Even formal proofs are error-prone for just two primitives (insert and delete).

## When to Use

- Collaborative text editing where character-level precision matters.
- Not suitable for non-text editors (design tools, diagram editors) where the complexity is not worth it.
