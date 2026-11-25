---
_type: Blog
_label: 'Practical DOD: Zig Compiler AST Representation'
url: 'https://vimeo.com/649009599'
journey: null
site: fref("/01-programming-language-theory/blogsites/andrew-kelley.td")
concepts:
  - fref("/01-programming-language-theory/02-concepts/abstract-syntax-tree-ast.td")
  - fref("/01-programming-language-theory/02-concepts/arena-allocator.td")
  - fref("/01-programming-language-theory/02-concepts/arena.td")
  - fref("/01-programming-language-theory/02-concepts/parsing.td")
tags:
  - 'talk'
---

Talk by Andrew Kelley (Zig creator) at Handmade Seattle 2021 on applying data-oriented design to the Zig compiler.

## Zig's AST Node Packing

- Each AST node is a **tag** plus **two `u32` words** whose meaning depends on the tag.
- Before reduction: **120 bytes** per node.
- After reduction: **~15.6 bytes** average per node.

```zig
const Tree = struct {
    tags: []NodeTag,         // enum: BinaryOp, Return, etc.
    data: []NodeData,        // fixed-size: two u32 integers
    extras: []u32,           // variable-length payloads
};
```

## Key Techniques

- **Pointer elimination**: child references use 32-bit array indices instead of 64-bit pointers, halving reference overhead.
- **Fixed-size `NodeData`**: every node gets exactly two `u32` slots. For nodes that need more (e.g., function calls with many args), one slot is an index into the `extras` array and the other is the length.
- **`MultiArrayList` (struct of arrays)**: the node array is stored as separate columns (tags, data, extras) instead of an array of structs. A pass that only checks node kinds reads one dense column without pulling data through the cache.
- **Side-tables for semantic analysis**: the AST is immutable after parsing. Later passes use parallel arrays (e.g., `resolved_symbols[node_index]`) instead of mutating nodes, keeping the base AST compact.

## Performance Results

- **20%** reduction in AST generation time.
- **40%** reduction in IR generation time.

::: note
This is the "denser" approach referenced in the Yuku article. The Zig compiler can get away with tag + two words because the compiler is the only consumer. Yuku keeps named, typed fields because it needs to generate a JS decoder for external tools.
:::
