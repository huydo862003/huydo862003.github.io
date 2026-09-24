---
_type: SoftEngConcept
_label: 'Conflict-free Replicated Data Type'
journey: fref("software-engineering/index.td")
status: 'learning'
tags:
  - 'collaboration'
---

A collection of data structures designed for replication across multiple computers in a distributed system.

## Properties

- Each replica can be updated independently and concurrently.
- An algorithm automatically resolves inconsistencies.
- All replicas are guaranteed to eventually converge (eventual consistency).

## Common Types

- **Grow-only set**: Only operation is "add". Adding twice is a no-op. Apply all updates in any order.
- **Last-writer-wins register**: A single value. Updates carry a value, timestamp, and peer ID. Latest wins (peer ID breaks ties).
- **G-Counter**: A counter that only increments. Each node maintains its own count. The total is the sum of all nodes.

## Strengths

- Mathematical guarantees of eventual consistency.
- No central authority needed.
- Well-studied foundation for distributed systems.

## Weaknesses

- Designed for decentralized systems, so they carry performance and memory overhead for tracking causality.
- In a centralized system (client-server), this overhead is unnecessary.

## Practical Insight

Even in a client-server setup, CRDTs are worth studying. They build intuition for creating correct systems. You can then relax requirements based on your needs (as Figma did).
