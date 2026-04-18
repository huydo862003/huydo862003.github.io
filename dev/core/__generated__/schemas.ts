// AUTO-GENERATED from content/.schemas/*.yaml
// do not edit manually - run `pnpm run codegen` to regenerate

import { z } from 'zod';

// common fields shared by all content types
const dates = {
  createdAt: z.string().default(''),
  updatedAt: z.string().default(''),
  author: z.string().default(''),
  published: z.boolean().default(false),
};

export const authorsSchema = z.object({
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
});
export type Authors = z.infer<typeof authorsSchema>;

export const blogsSchema = z.object({
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
});
export type Blogs = z.infer<typeof blogsSchema>;

export const booksSchema = z.object({
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
});
export type Books = z.infer<typeof booksSchema>;

export const conceptsSchema = z.object({
  ...dates,
  title: z.string(),
  journey: z.string().default(''),
  status: z.enum(['learning', 'reviewing', 'mastered']).default('learning'),
  tags: z.array(z.string()).default([]),
  books: z.array(z.string()).default([]),
  dependsOn: z.array(z.string()).default([]),
  blocks: z.array(z.string()).default([]),
  content: z.string(),
});
export type Concepts = z.infer<typeof conceptsSchema>;

export const flashcardsSchema = z.object({
  ...dates,
  question: z.string().default(''),
  deck: z.string().default('general'),
  tags: z.array(z.string()).default([]),
  concepts: z.array(z.string()).default([]),
  books: z.array(z.string()).default([]),
  content: z.string(),
});
export type Flashcards = z.infer<typeof flashcardsSchema>;

export const journeysSchema = z.object({
  ...dates,
  title: z.string(),
  description: z.string().default(''),
  status: z.enum(['active', 'paused', 'completed']).default('active'),
  tags: z.array(z.string()).default([]),
  content: z.string(),
});
export type Journeys = z.infer<typeof journeysSchema>;

export const papersSchema = z.object({
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
});
export type Papers = z.infer<typeof papersSchema>;

export const phasesSchema = z.object({
  ...dates,
  title: z.string(),
  journey: z.string().default(''),
  status: z.enum(['active', 'on-hold', 'completed']).default('on-hold'),
  order: z.number().default(0),
  books: z.array(z.string()).default([]),
  concepts: z.array(z.string()).default([]),
  content: z.string(),
});
export type Phases = z.infer<typeof phasesSchema>;

export const thoughtsSchema = z.object({
  ...dates,
  title: z.string(),
  date: z.string().default(''),
  description: z.string().default(''),
  tags: z.array(z.string()).default([]),
  archived: z.boolean().default(false),
  concepts: z.array(z.string()).default([]),
  journeys: z.array(z.string()).default([]),
  content: z.string(),
});
export type Thoughts = z.infer<typeof thoughtsSchema>;

export const allSchemas = {
  authors: authorsSchema,
  blogs: blogsSchema,
  books: booksSchema,
  concepts: conceptsSchema,
  flashcards: flashcardsSchema,
  journeys: journeysSchema,
  papers: papersSchema,
  phases: phasesSchema,
  thoughts: thoughtsSchema,
} as const;

export enum ContentType {
  Authors = 'authors',
  Blogs = 'blogs',
  Books = 'books',
  Concepts = 'concepts',
  Flashcards = 'flashcards',
  Journeys = 'journeys',
  Papers = 'papers',
  Phases = 'phases',
  Thoughts = 'thoughts',
}
