import {
  defineCollection, defineConfig,
  type CollectionContext,
} from '@content-collections/core';
import { z } from 'zod';
import {
  authorsSchema, blogsSchema, booksSchema, conceptsSchema,
  flashcardsSchema, journeysSchema, papersSchema, phasesSchema, thoughtsSchema,
} from './dev/core/__generated__/schemas';

function stripContent<T extends Record<string, unknown>> (
  doc: T & { content?: string; published?: boolean },
  { skip }: CollectionContext<T>,
) {
  if (doc.published === false) return skip('unpublished');
  const { content: _, ...rest } = doc;
  return rest;
}

const concepts = defineCollection({
  name: 'concepts',
  directory: 'content/concepts',
  include: '**/*.md',
  schema: conceptsSchema,
  transform (doc, { skip }) {
    if (doc.published === false) return skip('unpublished');
    const { content, ...rest } = doc;
    const description = content.trim().split(/\n\n/)[0]?.trim() ?? '';
    return { ...rest, description };
  },
});

const flashcards = defineCollection({
  name: 'flashcards',
  directory: 'content/flashcards',
  include: '**/*.md',
  schema: flashcardsSchema,
  transform (doc, { skip }) {
    if (doc.published === false) return skip('unpublished');
    const { content, ...rest } = doc;
    return { ...rest, answer: content.trim() };
  },
});

const journeys = defineCollection({
  name: 'journeys',
  directory: 'content/journeys',
  include: '**/*.md',
  schema: journeysSchema,
  transform: stripContent,
});

const phases = defineCollection({
  name: 'phases',
  directory: 'content/phases',
  include: '**/*.md',
  schema: phasesSchema,
  transform: stripContent,
});

const books = defineCollection({
  name: 'books',
  directory: 'content/books',
  include: '**/*.md',
  schema: booksSchema,
  transform: stripContent,
});

const blogs = defineCollection({
  name: 'blogs',
  directory: 'content/blogs',
  include: '**/*.md',
  schema: blogsSchema,
  transform: stripContent,
});

const papers = defineCollection({
  name: 'papers',
  directory: 'content/papers',
  include: '**/*.md',
  schema: papersSchema,
  transform: stripContent,
});

const thoughts = defineCollection({
  name: 'thoughts',
  directory: 'content/thoughts',
  include: '**/*.md',
  schema: thoughtsSchema,
  transform: stripContent,
});

// graph link extraction - separate collection so link data doesn't bloat main metadata
const WIKI_LINK_RE = /\[\[([^\]|]+)(?:\|[^\]]+)?\]\]/g;
const INTERNAL_LINK_RE = /\[(?:[^\]]+)\]\(\/journeys\/[^)]+\/(?:concepts|books|flashcards|phases)\/([^)]+)\)/g;

function extractLinks (content: string): string[] {
  const links = new Set<string>();
  for (const m of content.matchAll(WIKI_LINK_RE)) links.add(m[1].trim());
  for (const m of content.matchAll(INTERNAL_LINK_RE)) links.add(m[1].trim());
  return [...links];
}

const graph = defineCollection({
  name: 'graph',
  directory: 'content',
  include: '**/*.md',
  exclude: ['_configs/**'],
  schema: z.object({
    published: z.boolean().default(false),
    title: z.string().default(''),
    question: z.string().default(''),
    journey: z.string().default(''),
    concepts: z.array(z.string()).default([]),
    books: z.array(z.string()).default([]),
    dependsOn: z.array(z.string()).default([]),
    children: z.array(z.string()).default([]),
    parent: z.string().default(''),
    content: z.string(),
  }),
  transform (doc, { skip }) {
    if (doc.published === false) return skip('unpublished');
    const slug = doc._meta.fileName.replace('.md', '');
    const dir = doc._meta.filePath.split('/')[0];
    const bodyLinks = extractLinks(doc.content ?? '');
    const fmLinks = [
      ...doc.concepts, ...doc.books, ...doc.dependsOn,
      ...doc.children, ...(doc.parent ? [doc.parent] : []),
    ];
    return {
      slug, type: dir,
      title: doc.title || doc.question || slug,
      journey: doc.journey,
      forwardLinks: [...new Set([...bodyLinks, ...fmLinks])],
    };
  },
});

const authors = defineCollection({
  name: 'authors',
  directory: 'content/authors',
  include: '**/*.md',
  schema: authorsSchema,
  transform: stripContent,
});

export default defineConfig({
  content: [concepts, flashcards, journeys, phases, books, blogs, papers, thoughts, authors, graph],
});
