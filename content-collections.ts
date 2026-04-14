import {
  defineCollection, defineConfig,
  type CollectionContext,
} from '@content-collections/core';
import { z } from 'zod';

const dates = {
  createdAt: z.string().default(''),
  updatedAt: z.string().default(''),
  author: z.string().default(''),
  published: z.boolean().default(true),
};

// Strip the implicit `content` field and skip unpublished docs
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
  schema: z.object({
    ...dates,
    title: z.string(),
    journey: z.string().default(''),
    description: z.string().default(''),
    status: z.enum(['learning', 'reviewing', 'mastered']).default('learning'),
    tags: z.array(z.string()).default([]),
    keywords: z.array(z.string()).default([]),
    books: z.array(z.string()).default([]),
    dependsOn: z.array(z.string()).default([]),
    blocks: z.array(z.string()).default([]),
    content: z.string(),
  }),
  transform: stripContent,
});

const flashcards = defineCollection({
  name: 'flashcards',
  directory: 'content/flashcards',
  include: '**/*.md',
  schema: z.object({
    ...dates,
    question: z.string().default(''),
    answer: z.string().default(''),
    deck: z.string().default('general'),
    tags: z.array(z.string()).default([]),
    keywords: z.array(z.string()).default([]),
    concepts: z.array(z.string()).default([]),
    books: z.array(z.string()).default([]),
    content: z.string(),
  }),
  transform: stripContent,
});

const journeys = defineCollection({
  name: 'journeys',
  directory: 'content/journeys',
  include: '**/*.md',
  schema: z.object({
    ...dates,
    title: z.string(),
    description: z.string().default(''),
    status: z.enum(['active', 'paused', 'completed']).default('active'),
    tags: z.array(z.string()).default([]),
    content: z.string(),
  }),
  transform: stripContent,
});

const phases = defineCollection({
  name: 'phases',
  directory: 'content/phases',
  include: '**/*.md',
  schema: z.object({
    ...dates,
    title: z.string(),
    journey: z.string().default(''),
    status: z.enum(['active', 'on-hold', 'completed']).default('on-hold'),
    order: z.number().default(0),
    books: z.array(z.string()).default([]),
    concepts: z.array(z.string()).default([]),
    content: z.string(),
  }),
  transform: stripContent,
});

const books = defineCollection({
  name: 'books',
  directory: 'content/books',
  include: '**/*.md',
  schema: z.object({
    ...dates,
    title: z.string(),
    author: z.string().default(''),
    date: z.string().default(''),
    journey: z.string().default(''),
    description: z.string().default(''),
    isbn: z.string().default(''),
    url: z.string().default(''),
    cover: z.string().default(''),
    tags: z.array(z.string()).default([]),
    concepts: z.array(z.string()).default([]),
    parent: z.string().default(''),
    children: z.array(z.string()).default([]),
    content: z.string(),
  }),
  transform: stripContent,
});

const blogs = defineCollection({
  name: 'blogs',
  directory: 'content/blogs',
  include: '**/*.md',
  schema: z.object({
    ...dates,
    title: z.string(),
    url: z.string().default(''),
    author: z.string().default(''),
    journey: z.string().default(''),
    site: z.string().default(''),
    latestPost: z.string().default(''),
    lastChecked: z.string().default(''),
    posts: z.array(z.string()).default([]),
    tags: z.array(z.string()).default([]),
    content: z.string(),
  }),
  transform: stripContent,
});

const papers = defineCollection({
  name: 'papers',
  directory: 'content/papers',
  include: '**/*.md',
  schema: z.object({
    ...dates,
    title: z.string(),
    authors: z.array(z.string()).default([]),
    year: z.string().default(''),
    venue: z.string().default(''),
    url: z.string().default(''),
    journey: z.string().default(''),
    tags: z.array(z.string()).default([]),
    concepts: z.array(z.string()).default([]),
    status: z.enum(['to-read', 'reading', 'read']).default('to-read'),
    content: z.string(),
  }),
  transform: stripContent,
});

const thoughts = defineCollection({
  name: 'thoughts',
  directory: 'content/thoughts',
  include: '**/*.md',
  schema: z.object({
    ...dates,
    title: z.string(),
    date: z.string().default(''),
    description: z.string().default(''),
    tags: z.array(z.string()).default([]),
    archived: z.boolean().default(false),
    concepts: z.array(z.string()).default([]),
    journeys: z.array(z.string()).default([]),
    content: z.string(),
  }),
  transform: stripContent,
});

// Graph link extraction — separate collection so link data doesn't bloat main metadata
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
    published: z.boolean().default(true),
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
    const dir = doc._meta.filePath.split('/')[0]; // concepts, books, etc.
    const bodyLinks = extractLinks(doc.content ?? '');

    // Collect all explicit refs from frontmatter
    const fmLinks = [
      ...doc.concepts,
      ...doc.books,
      ...doc.dependsOn,
      ...doc.children,
      ...(doc.parent ? [doc.parent] : []),
    ];

    return {
      slug,
      type: dir,
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
  schema: z.object({
    ...dates,
    name: z.string(),
    bio: z.string().default(''),
    url: z.string().default(''),
    dateOfBirth: z.string().default(''),
    origin: z.string().default(''),
    education: z.array(z.string()).default([]),
    interests: z.array(z.string()).default([]),
    tags: z.array(z.string()).default([]),
    content: z.string(),
  }),
  transform: stripContent,
});

export default defineConfig({
  content: [concepts, flashcards, journeys, phases, books, blogs, papers, thoughts, authors, graph],
});
