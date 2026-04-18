# scrambled

A static page hosted on Github Pages with a lightweight free-tier database to persist some non-private data.

This page tracks my scattered thoughts and learning journeys for many topics + with a flashcard system for revision.

Note: Just performed some batch migrations from Notion, so formatting would break here and there.

Disclaimer: The frontend page (not the note content) is AI-generated. I wrote the notes myself. That's fine because I want to go into noting as soon as possible.

## Development/Authoring guide

Prerequisites:

- Node (not too old)
- pnpm

Commands for content management:

```bash
pnpm install              # install dependencies
pnpm dev                  # host the blog locally at localhost:3000
pnpm new:author           # create a new author
pnpm new:journey          # create a new guided journey
pnpm new:phase            # create a new phase for a journey
pnpm new:concept          # create a new concept for a journey
pnpm new:card             # create a new flashcard for a journey, can be linked to a concept
pnpm new:post             # create a new (standalone) thought
```

Alternatively, you can open obsidian in the `./content` folder. Make sure to use one of the registered templates in `./content/_configs/` so that the blog app can render the content properly.

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
