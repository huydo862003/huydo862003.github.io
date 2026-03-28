# scrambled

A static page hosted on Github Pages with a lightweight free-tier database to persist some non-private data.

This page tracks my scattered thoughts and learning journeys for many topics + with a flashcard system for revision.

Note: Just performed some batch migrations from Notion, so formatting would break here and there.

## Markdown guide

### Cross-links

```md
[[slug]] # auto-resolves title
[[slug|custom label]] # custom label
```

Works across all content types. Unresolved slugs show in red.

### Math

```md
Inline: $e : \tau$
Display: $$\frac{a}{b}$$
```

### Code blocks

````md
```coq
Theorem ex : forall n, 0 + n = n.
```
````

Languages: `coq`/`rocq`, `haskell`, `ocaml`, `scheme`, `python`, `javascript`, `typescript`, `bash`, `css`.

### Callouts

```md
::: tip
Content.
:::
```

Types: `tip`, `warning`, `note`, `key`, `question`, `insight`, `important`.

### Collapsible

```md
<details>
<summary>Solution</summary>

Content here.

</details>
```

Blank line required after `</details>` before headings.

## Dev

```sh
pnpm dev
pnpm build
pnpm lint --fix
```
