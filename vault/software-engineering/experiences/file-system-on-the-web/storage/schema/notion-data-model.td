---
_type: ExperienceResource
_label: "Notion: Block-Based Data Model"
experience: fref("software-engineering/experiences/file-system-on-the-web/index.td")
url: "https://www.notion.com/blog/data-model-behind-notion"
kind: 'blog-post'
tags:
  - 'metadata'
---

- How Notion models everything (pages, databases, text, images, files) as blocks in PostgreSQL.
- This is not a traditional filesystem schema, but a relevant alternative: A single unified data model for all content types.

## Core Concept: Everything is a Block

Every piece of content in Notion is a block. Text, images, lists, database rows, and pages are all blocks.

```
Block {
  id:         uuid v4        -- Unique identifier. Appears in page URLs.
  type:       string         -- "text", "to_do", "heading", "page", etc.
  properties: object         -- Custom attributes. Most common is `title`.
  content:    [block_id]     -- Ordered child block IDs ("downward pointers").
  parent:     block_id       -- Parent block ID ("upward pointer"). Permissions only.
}
```

A concrete example: A to-do block with 3 child items.

```
{
  "id": "e7e93fae",
  "type": "to_do",
  "properties": {
    "title": [["Write a blog post about blocks"]],
    "checked": [["No"]]
  },
  "content": ["00315dfb", "bf2d3c32", "3070827f"],
  "parent": "fc32e031"
}
```

The `content` array points down to 3 child blocks. Each child's `parent` points back up:

```mermaid
graph TD
    Todo["to_do: Write a blog post<br/>id: e7e93fae"]
    Child1["to_do: Do a rough first draft<br/>parent: e7e93fae"]
    Child2["to_do: Clean it up<br/>parent: e7e93fae"]
    Child3["to_do: Share it with the world!<br/>parent: e7e93fae"]

    Todo -->|"content[0]"| Child1
    Todo -->|"content[1]"| Child2
    Todo -->|"content[2]"| Child3

    Child1 -.->|parent| Todo
    Child2 -.->|parent| Todo
    Child3 -.->|parent| Todo
```

- Solid arrows = `content` (downward, for rendering).
- Dotted arrows = `parent` (upward, for permissions).

### Type Transformation

"Turn into" changes a block's type without changing its properties or content. A checked to-do can become a heading, then back to a to-do, and it is still checked. This works because property storage is decoupled from block type.

```
Block { type: "to_do", properties: { title: "Write blog", checked: "Yes" } }
  -- Turn into Heading -->
Block { type: "heading", properties: { title: "Write blog", checked: "Yes" } }
  -- Turn back to To-do -->
Block { type: "to_do", properties: { title: "Write blog", checked: "Yes" } }
```

::: note
This decoupling is also essential for collaboration: It preserves as much user intention as possible when block types change.
:::

## Hierarchy: The Render Tree

Blocks form a tree. Different types render their children differently:

- List blocks (text, bullets, to-dos) display their children indented below.
- Toggles only display children when expanded.
- Pages display their children in a separate page view.

::: note
The visual structure of a Notion doc directly mirrors the block tree structure. Indentation in Notion is structural (moves a block into the sibling's content array), not presentational (just spacing from margin).
:::

Pressing Tab on Text 3 moves it into Text 2's content array:

```mermaid
graph TD
    subgraph Before TAB
        B_Page[Page] -->|content| B_T1[Text 1]
        B_Page -->|content| B_T2[Text 2]
        B_Page -->|content| B_T3[Text 3]
    end

    subgraph After TAB
        A_Page[Page] -->|content| A_T1[Text 1]
        A_Page -->|content| A_T2[Text 2]
        A_T2 -->|content| A_T3[Text 3]
    end
```

Text 3 moved from Page's content into Text 2's content.

## Permissions

Permissions use upward pointers (parent), not content arrays. Two reasons:

1. A block can be referenced by multiple content arrays.
   - This makes it ambiguous which parent grants permissions.
   - Ambiguity is unacceptable in a permissions system.
2. Permission checks need to walk up to the workspace root.
   - Searching through all content arrays is inefficient, especially on the client.

The parent pointer solves both: You can walk straight up from any block to the workspace root.

```mermaid
graph BT
    Block["Text block"] -->|parent| Page2["Page 2"]
    Page2 -->|parent| RootPage["Root Page"]
    RootPage -->|parent| Workspace["Workspace (root)"]
```

To check permissions for "Text block", the system walks up: parent -> Page 2 -> Root Page -> Workspace. Each level can grant or restrict access.

## Life of a Block

### Creating (Client-Side)

1. Client generates a unique ID, sets type (e.g. `to_do`), fills properties (empty `title`, `checked: [["No"]]`).
2. Client creates operations for the new block and an operation to add it to the parent's content array.
3. Operations are grouped into a **transaction**.
4. Client applies the transaction to local state immediately (re-renders within milliseconds).
5. Transaction is saved to **TransactionQueue** (IndexedDB or SQLite) until the server confirms or rejects.

### Saving (Server-Side)

Transaction is serialized to JSON and posted to `/saveTransactions`:

1. Load all blocks and parents involved (the "before" picture).
2. Duplicate "before" data, apply transaction operations to create "after" data.
3. Validate changes for permissions and data coherency.
4. Commit created/changed records to the database.
5. Send "success" HTTP response.
6. Schedule background work: Version history snapshots, indexing block text for Quick Find.
7. Notify **MessageStore** of changes.

### Realtime Updates

Every client holds a long-lived WebSocket connection to MessageStore (Notion's realtime service). When a block is rendered, the client subscribes to changes for that specific block.

1. After `saveTransactions` succeeds, the API notifies MessageStore of new recorded versions.
2. MessageStore broadcasts to all clients subscribed to those blocks.
3. Client receives version notification, checks local cache.
   - If versions differ, sends `syncRecordValues` API request with the list of outdated records.
4. Server responds with new data.
   - Client updates local cache and re-renders.

### Reading Blocks

1. Client first tries local data (in-memory on web, RecordCache on native apps).
2. If missing, requests from `loadPageChunk` API.
3. `loadPageChunk` descends from a page block ID down the content tree.
   - Returns all blocks + dependent records needed to render.
4. Multiple caching layers exist.
   - In the worst case, this requires recursive database traversal.
5. All loaded data goes into memory (and RecordCache on native apps).
   - React renders the page.

## Storage

- **Server**: PostgreSQL on Amazon RDS. As of 2023, 96 database servers, each with 5 logical shards (PostgreSQL schemas).
- **Client**: RecordCache, an LRU cache on SQLite (native apps) or IndexedDB (web). All accessed records are cached locally.

## Takeaways for Our System

- **Unified block model** is powerful for flexible content, but may be overkill if our content types are simple (files + folders).
- **Parent pointer for permissions, content array for rendering**: Clean separation of concerns. We could adopt this if we need per-block permissions.
- **Sharding by block ID**: Works because blocks are accessed by ID. If we use path-based access, sharding gets harder.
- **Transaction-based writes**: Atomic batches of operations. Unlike GitHub Contents API (one commit per file), this supports multi-block atomic updates.
- **TransactionQueue on the client**: Ensures no data loss if the network drops. Transactions are persisted locally until confirmed by the server.
- **Per-block WebSocket subscriptions**: Only blocks currently rendered are subscribed. Efficient for large workspaces where most blocks are not visible.
