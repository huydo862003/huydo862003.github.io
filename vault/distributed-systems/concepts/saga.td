---
_type: DistSysConcept
_label: 'Saga pattern'
journey: fref("distributed-systems/index.td")
status: 'learning'
tags:
  - 'distributed systems'
  - 'microservices'
  - 'transactions'
---

## Saga Pattern

A pattern that only arises in systems that have distributed databases and want to perform a transaction that span several databases in a way that is close to the desirable ACID properties.

### Example Scenario

You have:

- A micro-service system that have separate databases for each service.
- A business transaction that spans multiple services.
- We want as much as atomicity, consistency, isolation and durability as possible (possibly with different prioritization).

This essentially disables us from using a local ACID transaction.

How do we implement the business transaction?

> Remark
> I think this is one of the major pain points of scaling to microservices...

### Problems that SAGA is Intended to Solve

> Problem: How do we implement distributed transactions (ones that span multiple services)

### Solution

The general idea of SAGA is:

1. Each service carries out its steps in the business transaction within its own local ACID transaction.
2. Then when completed, each service would notify in some ways so other services can carry on.
3. If at some point, a service fails to carry on, it will notify the others in some ways so the completed services can issue "compensation transactions" to undo the effects of the completed steps.

::: warning

There are multiple pitfalls to this:
- "compensation" != "rollback": It doesn't mean each service deletes a record that was previously added. It means that the service issues additional records that essentially undo the added invalid records.
- Not every operations can be compensated, so operations must be carefully designed to be compensable. Else, they must be excluded from the SAGA chain.
:::

#### Two Patterns

This sections explains two patterns usually used in SAGA

##### Choreography-based SAGA

No central coordinator.

Each service listens for events, completes its local transaction, and emits an event that triggers the next service. The SAGA flow is implicit: scattered across services' event handlers.

- Decoupled, no single point of failure.
- Flow is hard to trace and debug because there is no single place describes it.
- Gets messy beyond 2-3 steps.

##### Orchestration-based SAGA

A central orchestrator holds the SAGA's state machine. It tells each service what to do, waits for replies, and triggers compensations on failure. The SAGA flow is explicit - lives in one place.

- Easy to reason about, trace, and modify.
- Participating services stay simple - just handle commands.
- Orchestrator is a single point of failure, can become a god object if not scoped per-SAGA.

> Remark
> Choreography should work fine for simple 2-3 step SAGAs. Beyond that, orchestration is usually easier to maintain.

#### Analysis

SAGA enables data (eventual) consistency across multiple services without distributed transactions.

##### Drawbacks

- Lack of automatic rollback: there's no magic undo button. The developer must explicitly design compensating transactions for every step. Each compensation must be idempotent, must always be valid to execute regardless of system state, and must semantically reverse the original step (not literally rollback the local transaction).
- Lack of isolation (the "I" in ACID): nothing prevents other SAGAs or transactions from reading intermediate state mid-SAGA. Concurrent SAGAs can step on each other - e.g. one SAGA reads data that another SAGA will later compensate away. Developers must apply countermeasures (semantic locks, commutative updates, pessimistic/optimistic reads) to mitigate these anomalies. This requires careful per-case analysis.

##### Additional Concerns

- Atomicity of update + publish: Each step needs to atomically update its database and publish an event.
  - You can't just do a DB write then send a message if the app crashes between the two, you get inconsistency.
  - This is a separate problem that needs its own solution (transactional outbox pattern, event sourcing, CDC).

- Parallel steps: SAGA steps can run in parallel (orchestrator sends to multiple services at once, or multiple services react to the same event).
  - Compensation gets tricky though, if one parallel branch fails, you need to compensate all other branches that already succeeded.
  - Even messier if some branches are still in-progress: do you wait for them to finish then compensate, or cancel mid-flight?

- Synchronous clients on async flows: the SAGA is async, but clients usually initiate it via a sync request. The client needs to know the outcome somehow:
  - Hold the connection open until SAGA completes (simple but ties up resources, risky with timeouts).
  - Return immediately with an id, client polls for result (simple but adds latency and chattiness).
  - Return immediately with an id, push result via websocket/webhook (responsive but more infrastructure).
