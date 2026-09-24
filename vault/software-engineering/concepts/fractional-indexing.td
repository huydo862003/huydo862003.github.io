---
_type: SoftEngConcept
_label: 'Fractional Indexing'
journey: fref("software-engineering/index.td")
status: 'learning'
tags:
  - 'collaboration'
---

A technique for maintaining ordered lists in distributed systems without reindexing.

## How It Works

- Each item's position is a fraction between 0 and 1 (exclusive).
- Items are sorted by their position values.
- To insert between two items, set the new item's position to the average of their positions.
- No other items need to be updated (no reindexing).

## Where It Appears

- Figma uses fractional indexing to order children within a parent object.
- The parent link and position are stored as a single property so they update atomically.

## Tradeoffs

- Positions can lose precision after many insertions (fractions get very long).
- In practice, periodic rebalancing or using string-based fractional indices avoids this.
