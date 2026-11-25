---
_type: Blog
_label: "Data-Oriented Design in Yuku's Parser"
url: 'https://www.arshad.fyi/writings/data-oriented-design-in-yukus-parser'
journey: null
site: fref("/01-programming-language-theory/blogsites/arshad-yaseen.td")
concepts: []
---

**Yuku** is a JS/TS parser written in Zig. It's able to parses `typescript.js` (8 MB) in ~12 ms on M3.

It is a plain recursive descent parser, written from the spec.

::: note Key Insights
The speed comes from how the tree sits in memory and how the representation crosses the JS boundary cheaply:

1. **Indices instead of pointers** (#1): all nodes in one arena, `u32` indices replace pointers. Variable-length children go into a shared `extras` array. Columnar storage (`MultiArrayList`) for cache-friendly passes.
2. **Scratch buffers** (#2): reusable stacks for accumulating variable-length children during parsing. Checkpoint/flush/truncate pattern avoids per-block allocation. Same mechanism enables free backtracking.
3. **Strings as offsets** (#3): most strings point directly into the source buffer. A small flat byte pool holds the few decoded strings (e.g., escape sequences). Source and pool share one continuous offset space.
4. **Crossing into JS** (#4): because the tree is position-independent bytes (no pointers), serialization is mostly a memcpy into an `ArrayBuffer`. Fixed-size node records with compile-time layout. Generated JS decoder reads typed arrays directly.
:::

Benchmarks (native, `typescript.js`): Even faster than Oxc!

- **Yuku**: 12.9 ms
- **Oxc**: 24.6 ms (1.9x slower)
- **SWC**: 42.7 ms (3.3x slower)

## Naive Approach & Problem: The Pointer Tree

The usual AST shape:

```zig
const Node = union(enum) {
  binary: struct { op: Op, left: *Node, right: *Node },
  call: struct { callee: *Node, args: []*Node },
  identifier: struct { name: []const u8 },
  // ...
};
```

Problems:

- **Each node is its own heap allocation**

  - Every tree walk is **a chain of dependent loads** the CPU can't predict.
- The representation is full of **absolute addresses**:

  - Hard to serialize.
  - The tree only means something inside the process that built it, can't write to disk or hand to JS without rebuilding object by object.

## Yuku's Solution #1: Indices Instead of Pointers

Idea: Nodes allocated in an arena:

- All nodes live in one array.
- Every pointer replaced with a `u32` index into the array.

Nuances:

- `maxInt(u32)` means "no child", so optional children cost nothing extra.
- **Variable-length children** (e.g., statements of a block) go into a second shared array called `extras`, the node stores a start index and a length.
- Everything comes from one arena, so freeing the tree is one call.

```zig
pub const NodeIndex = enum(u32) { null = std.math.maxInt(u32), _ };

pub const Tree = struct {
  nodes: std.MultiArrayList(Node),
  extras: std.ArrayList(NodeIndex),
  strings: StringPool,
  source: []const u8,
  arena: std.heap.ArenaAllocator,
  // ...
};
```

Example: for `let x = 1 + 2;` the arena is:

```
[0] binding_identifier    4..5    name=4..5 ("x")
[1] numeric_literal       8..9    raw=8..9 ("1")
[2] numeric_literal       12..13  raw=12..13 ("2")
[3] binary_expression     8..13   left=1 right=2 operator=add
[4] variable_declarator   4..13   id=0 init=3
[5] variable_declaration  0..14   kind=let declarators=extras[0..1]
[6] program               0..14   body=extras[1..2]

extras: [ 4 ][ 5 ]
```

> So `extras` is an array that gets pushed a number of indices when a node has variable number of children, and that node will record the indices of the range.

**Additional properties**:

- Children are always built before parents, root is the last node.
- A plain loop from first to last is a post-order walk, no recursion, no stack. -> Same as ${fref("./flattening-asts.td")}.

### Struct of Arrays (Columnar Storage)

> Essentially data-oriented design: Struct of Arrays offers better compaction than Array of Structs when your workload typically involves scanning one field at a time.

- The node array is stored as **columns** (`MultiArrayList`), not as an array of structs.
- A pass that only switches on node kinds reads one dense column and never pulls spans through the cache.

```
array of structs                  struct of arrays
[ data | span ][ data | span ]    data: [ d0 ][ d1 ][ d2 ] ...
                                  span: [ s0 ][ s1 ][ s2 ] ...
```

## Yuku's Solution #2: Scratch Buffers

Problem: a block doesn't know how many statements it has until the closing brace. Allocating a growable list per block/call/array literal would put the allocator back on the hot path.

Solution: the parser keeps a few **scratch stacks** for the whole parse.

- A list records the stack's length when it begins, pushes items, copies them into `extras` in one go when it ends, and truncates the stack back.

```zig
pub fn parseBody(self: *Parser, terminator: ?TokenTag) !ast.IndexRange {
  const checkpoint = self.scratch_statements.begin();
  defer self.scratch_statements.reset(checkpoint);
  while (!self.isAtBodyEnd(terminator)) {
    const statement = try statements.parseStatement(self, .{});
    try self.scratch_statements.append(self.allocator(), statement);
  }
  return self.flushToExtras(&self.scratch_statements, checkpoint);
}
```

Example: `{ a; { b; c; } d; }` with B as the inner block:

```
scratch     extras
[a]         []              outer block, after a;
[a|b c]     []              inner block pushes on top
[a]         [b c]           inner flushes, truncates back
[a B d]     [b c]           outer resumes
[]          [b c|a B d]     outer flushes
```

- Nesting costs nothing because the inner list is flushed and gone before the outer one continues.
- Only lists that grow at the same time need separate stacks (e.g., strings and expressions of a template literal).

> Quick question: Why don't they just push directly to `extras`?
> Answer: Recursive parsing wouldn't work.

### Backtracking

- TypeScript sometimes forces the parser to guess, e.g., whether `<T>(x) => x` is a generic arrow or JSX.
- A checkpoint is the lexer position plus the lengths of the node, extras, and diagnostics arrays.
- Rewinding just truncates them, whatever a failed attempt built is just the tail of those arrays, nothing to free.

## Yuku's Solution #3: Strings Are Offsets

Idea:

- Almost every string a parser produces (identifiers, keywords, raw literals) already exists verbatim in the source. Yuku avoids copying them: a "string" is just a `(start, end)` offset pair that points directly into the source buffer.
- But a few strings don't exist verbatim in the source. For example, `"a\nb"` appears as the bytes `a`, `\`, `n`, `b` in the source, but its actual value is `a`, newline, `b`. These decoded strings are appended into a small flat byte array called the **extra pool** (not an array of strings, just raw bytes back-to-back, sliced by offset pairs the same way as the source).

To address both cases with one offset space, Yuku concatenates the source and pool into a single number line:

```
 0 .................. src_len .................. src_len + pool_len
 |--- source bytes ---|--- extra pool bytes ---|
```

- If `start < src_len`, the string lives in the source buffer, just slice it directly.
- If `start >= src_len`, subtract `src_len` to index into the extra pool.

```zig
pub fn get(self: *const StringPool, id: String) []const u8 {
  const src_len: u32 = @intCast(self.source.len);
  if (id.start < src_len) return self.source[id.start..id.end];
  return self.extra.items[id.start - src_len .. id.end - src_len];
}
```

Example: `let x = "a\nb";` (15 bytes of source, 3 bytes in pool)

```
source (15 bytes)                          pool (3 bytes)
 0   1   2   3   4   5   6   7   8   9  10  11  12  13  14  15  16  17
[l] [e] [t] [ ] [x] [ ] [=] [ ] ["] [a] [\] [n] [b] ["] [;]  [a] [\n] [b]
                                     ^^^^^^^^^^^^^^^^^^^^^^    ^^^^^^^^^
                                     raw = 8..14               value = 15..18
                                     (slice source directly)   (decoded into pool)
```

- The lexer never decodes while scanning. It records the span and sets a flag if it saw a backslash. Decoding only happens when the parser explicitly asks for the value.
- For an 8 MB file, the pool stays tiny since the vast majority of strings point directly into the source.
- At the JS boundary, the caller already has the source as a string, so the JS decoder uses the same rule: offsets below `src_len` slice the caller's string, offsets past it read the pool. Only the pool crosses the boundary. The source text itself is never copied.

## Yuku's Solution #4: Crossing into JavaScript

- Most JS tools need the AST as JS objects, this is where native parsers usually lose.
- Serializing to JSON + `JSON.parse`, or building objects one at a time through N-API, often costs more than the parse itself.
- Yuku's tree has no pointers anywhere (children are indices, lists are offsets into extras, strings are offsets into source), it is already **position-independent bytes**, so serializing is mostly a copy.

```
header | nodes   | extras  | string pool | comments | diagnostics
         packed    memcpy    memcpy
```

- Yuku computes the exact size first, asks the JS engine for an `ArrayBuffer` of that size, and writes straight into it, no intermediate buffer.

### Fixed-Size Node Records

Each node is packed into a fixed record: a tag, flag bits, a row of `u32` slots, and the span. The mapping is derived at **compile time** from the fields of each AST struct:

- A `bool` takes one flag bit.
- An enum with *n* variants takes ceil(log2(n)) bits.
- A child takes one slot.
- A list or string takes two slots.
- If a node ever exceeds the record size, the build fails and names the node.

### Generated Decoder

- The JS decoder is generated by a Zig program that calls the same layout function at comptime, so encoder and decoder can't drift apart.

```js
case 8: {
  const f1 = _u32[b + 1], f2 = _u32[b + 2];
  return {
    type: "BinaryExpression", start, end,
    left: f1 !== NULL ? node(f1) : null,
    right: f2 !== NULL ? node(f2) : null,
    operator: BINARY_OPS[flags & 31],
  };
}
```

- No parsing on the JS side, only reads from a typed array.
- Each kind is created as an object literal with a fixed key order, so V8 gives every node of a kind the same hidden class.

### UTF-16 Offset Conversion

Problem: Zig's offsets count UTF-8 bytes, but JS string positions count UTF-16 code units. These two counting systems agree as long as every character is ASCII (1 byte in UTF-8 = 1 code unit in UTF-16), so pure-ASCII files need no conversion at all.

For files with non-ASCII characters, the counts diverge:

- A 2-byte UTF-8 character (e.g., `é`) is still 1 UTF-16 code unit.
- A 4-byte UTF-8 character (e.g., an emoji) becomes 2 UTF-16 code units (a surrogate pair).

Yuku's solution: a bitmap with **one bit per source byte**, marking the bytes where a new UTF-16 code unit starts. The bitmap is divided into fixed-size blocks, each with a running count of UTF-16 units up to that block's start.

The bitmap is built **lazily on first use** (not during lexing or parsing). [PR #223](https://github.com/yuku-toolchain/yuku/pull/223) shows that previously every file paid for a UTF-16 position map upfront, but deferring construction to first use gave a 12-31% reduction in file analysis costs.

To convert a UTF-8 byte offset to a UTF-16 offset:

1. Look up the block covering that offset to get the base count.
2. `popcount` the bits in the bitmap from the block start to the offset to get the remaining units.

This is O(1) per offset, with no scanning or table lookup chains. Internally (during parsing, semantic analysis, etc.), Yuku always works with UTF-8 byte offsets. The conversion only happens at the JS boundary, when packing span offsets into the `ArrayBuffer`.

### JS Benchmarks (`typescript.js`)

- **Yuku**: 43 ms
- **Acorn**: 145 ms (3.4x slower)
- **Babel**: 167 ms (3.9x slower)
- **Oxc**: 214 ms (4.9x slower)
- **SWC**: 380 ms (8.8x slower)

Runs on Node.js, Bun, Deno, browsers, and edge runtimes with no platform-specific tricks.

## What It Opens Up

- Native tools have always had trouble with JS extensions: plugins, custom transforms, and webpack/Rspack loaders all run in JS and need the tree there, often for every file in a project.
- Paying for the boundary on every file is what kept them slow.
- When the AST crosses as one copy and a decode, a native toolchain no longer has to choose between speed and letting people extend it in JS.
- Works in the other direction too: a tree changed in JS goes back to Zig in the same format to be printed.

Semantic analysis benchmarks (Svelte source, 416 files):

- **Yuku**: 28.2 ms
- **TypeScript**: 298 ms (10.6x slower)
- **typescript-eslint**: 317 ms (11.2x slower)

The design is in Rust now as well. SWC Next is built on a port of Yuku's AST, parser, and semantic analysis.

## Why Not Denser

- The Zig compiler packs its AST even tighter: a tag plus two words whose meaning depends on the tag. That's the right call when the compiler is the only consumer.
- Yuku's AST is for other people's tools, so nodes keep named, typed fields. This is also what makes generating the decoder possible.
