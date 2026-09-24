---
_type: ExperienceResource
_label: "Figma: Multiplayer Technology"
experience: fref("software-engineering/experiences/file-system-on-the-web/index.td")
url: "https://www.figma.com/blog/how-figmas-multiplayer-technology-works/"
kind: 'blog-post'
tags:
  - 'collaboration'
---

How Figma built live collaborative editing for a design tool.

In a nutshell:

- They did not use:
  - [OT](https://en.wikipedia.org/wiki/Operational_transformation): too complex for their more agile use case (elaborated below).
    > OT is used in Google Docs, etc.
  - [pure CRDTs](https://en.wikipedia.org/wiki/Conflict-free_replicated_data_type): too much overhead for a centralized system (elaborated below).
- Instead, they built a custom solution inspired by CRDTs but simplified by having a central server as the authority.

::: note
Closest model to our use case:
- Concurrent edits to a shared project trigger a full re-render of a visual canvas for all viewers.
- Similar to how editing file B should re-render the dbdiagram that imports B.
:::

## Background

This section walks through Figma architecture and how the multiplayer system is setup.

### Architecture

- Client/server architecture communicating over WebSockets.
  - Figma client = Web page.
  - Figma clients and a cluster of servers communicate over WebSockets.
- Multiplayer:
  - The server spins up a separate server process per multiplayer document.
  - All clients editing the same document connect to that process.
  - On open, the client downloads a full copy of the file.
  - From that point, updates sync over the WebSocket.
- Offline support:
  - Client can edit offline for an arbitrary amount of time.
  - On reconnect, client downloads a fresh copy, reapplies offline edits on top, and resumes syncing.

::: note
They only use this multiplayer system for syncing Figma document content.

Other data (comments, users, teams, projects) is stored in Postgres and synced via a completely separate system.
:::

### Multiplayer Approach

How Figma evaluates the possible multiplayer approaches.

#### Why Not OT?

Operational Transformation (OT):
 - Defines operations through offsets in text (insert at position N, delete at position M).
 - A central server transforms concurrent operations against each other to resolve conflicts.

Use cases:

- Collaborative **text editing**.
- Powers Google Docs and most collaborative text apps.

Pros:

- Low memory and performance overhead for long text documents.
- Well-studied, most well-known technique for collaborative editing.

Cons:

- OT is extremely hard to implement correctly. Even formally proving correctness for just two primitives (insert and delete) is error-prone. The state space is too large to reason about by hand.
- OT is suitable for text-based apps, but Figma is not.

**Why Figma rejected it**: Figma is a design tool, not a text editor. They did not need the power of OTs, and the complexity was not worth it.

::: note
Their primary goal: The multiplayer system should be no more complex than necessary.
:::

#### Why Not Pure CRDTs?

Conflict-free Replicated Data Types (CRDTs) refers to a class of data structures in which:

- They are replicated across multiple computers in a network.
- Each replica can be updated independently and concurrently.
- An algorithm automatically resolves inconsistencies, guaranteeing **eventual consistency** (all replicas converge if no more updates are made).

CRDTs are designed for **decentralized systems with no central authority**.

Examples:

- **Grow-only set**: Only operation is "add". Adding twice is a no-op. Apply all updates in any order.
- **Last-writer-wins register**: A single value. Updates carry a value, timestamp, and peer ID. Latest wins (peer ID breaks ties).

Pros:

- Mathematical guarantees of eventual consistency.
- Well-studied, solid foundation for distributed systems.

Cons:

- Unavoidable performance and memory overhead for tracking causality without a central authority.

**Why Figma rejected pure CRDTs**: Figma is centralized (the server is the authority), so they can drop the decentralization overhead. Their data structure is not a single CRDT but is inspired by multiple CRDTs in combination.

::: tip
Even in a client-server setup, CRDTs are worth studying. They provide solid foundations and build intuition for creating correct systems. You can then relax requirements based on your application's needs.
:::

### Document Structure

A Figma document is a tree of objects, similar to the HTML DOM:

```
Root
  Page 1
    Frame
      Rectangle
      Text
  Page 2
    ...
```

Each object has an ID and a collection of properties with values. The document can be thought of as:

```
Map<ObjectID, Map<Property, Value>>
```

Or a database with `(ObjectID, Property, Value)` tuples. Adding new features to Figma usually just means adding new properties to objects.

## Syncing Object Properties

The server tracks the latest value any client has sent for a given property on a given object. This is a **last-writer-wins register** per (ObjectID, Property) pair, except no timestamp is needed because the server defines the order.

Conflict rules:

- Two clients changing **different properties** on the same object do not conflict.
- Two clients changing the **same property** on different objects do not conflict.
- Two clients changing the **same property** on the **same object**: Last value to reach the server wins.

::: note
Changes are atomic at the property value boundary. If text is "B" and one client changes it to "AB" while another changes it to "BC", the result is either "AB" or "BC", never "ABC". This is fine because Figma is a design tool, not a text editor.
:::

### Avoiding Flickering

Property changes on the client are applied immediately (optimistic updates) for responsiveness. But if the client also applies every incoming server change, conflicting changes can "flicker" when older acknowledged values temporarily overwrite newer unacknowledged ones.

The solution: Discard incoming server changes that conflict with unacknowledged local property changes. The client's unacknowledged change is the best prediction of the eventual value because it is the most recent change in last-to-the-server order.

## Syncing Object Creation and Removal

- Object creation and removal are explicit actions in the protocol.
- Objects cannot be created implicitly by writing a property to an unassigned ID.
- Removing an object deletes all its data from the server (all properties).
- Deleted object properties are stored in the undo buffer of the client that performed the delete. If that client undoes the delete, it restores all properties.

::: note
This keeps long-lived documents from growing in size as they are edited. The server does not retain deleted object data.
:::

Object IDs are generated client-side: Each client has a unique client ID, which is included as part of newly-created object IDs. This guarantees uniqueness without server coordination and works offline.

## Syncing Trees of Objects

This is the most complicated part of the multiplayer system. Two goals for reparenting (moving an object between parents):

1. Reparenting should not conflict with unrelated property changes. Changing an object's color while someone else reparents it should both succeed.
2. Two concurrent reparenting operations for the same object should never result in two copies of that object.

### Approach: Parent Link on the Child

Many systems represent reparenting as delete + recreate with a new ID. This does not work because concurrent edits would be dropped when the object's identity changes.

Instead, the parent-child relationship is stored as a property on the child (a link to the parent). This preserves object identity and avoids the multiple-parent problem (which would happen if parents stored links to children).

### Cycle Detection

Parent links are just directed edges on a graph. Without restrictions, cycles can form. Example: Client A makes A a child of B, client B makes B a child of A.

- The server rejects parent updates that would cause a cycle.
- But the client can temporarily be in a state where it has sent an unacknowledged reparent AND received a conflicting reparent from the server.
- Figma's solution: Temporarily remove these objects from the tree until the server rejects the client's change and the object is reparented correctly.

::: note
The object temporarily disappears. This is a simple solution to a very rare temporary problem.
:::

### Child Ordering: Fractional Indexing

An object's position in its parent's children is a fraction between 0 and 1 (exclusive). Children are sorted by position. To insert between two objects, set the new object's position to the average of their positions.

The parent link and position must be stored as a **single property** so they update atomically. Using a position from one parent when reparented to another does not make sense.

## Implementing Undo

Undo in multiplayer is inherently confusing. Figma's guiding principle:

::: tip
If you undo a lot, copy something, and redo back to the present, the document should not change.
:::

The naive single-player redo means "put back what I did", which can overwrite what other people did. Figma's solution:

- An undo operation modifies redo history at the time of the undo.
- A redo operation modifies undo history at the time of the redo.

## Takeaways for Our System

- **Property-level granularity** is the right model for our case too. File metadata changes (rename, permissions) should not conflict with file content changes.
- **Last-writer-wins per property**: Simple and sufficient when the server is the authority. No timestamps needed.
- **Optimistic updates + discard stale server changes**: Same pattern as the GitHub Contents API's SHA-based CAS, but applied at the property level instead of the whole file.
- **Client-generated IDs**: Enables offline creation without server coordination. We could use the same pattern for new files.
- **CRDTs as inspiration, not dogma**: We do not need decentralized guarantees. A centralized server lets us simplify significantly.
- **Prototype first**: Figma built a prototype simulating 3 clients + server before grafting onto their codebase. Worth doing for our sync system too.
