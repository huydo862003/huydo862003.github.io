import { defineStore } from 'pinia';
import { allBooks } from 'content-collections';
import type { Book } from '@/types/book';

const all: Book[] = allBooks.map((b) => ({
  slug: b._meta.fileName.replace('.md', ''),
  createdAt: b.createdAt ?? '',
  updatedAt: b.updatedAt ?? '',
  title: b.title,
  author: b.author,
  date: String(b.date ?? ''),
  journey: b.journey,
  tags: b.tags,
  concepts: b.concepts,
  parent: b.parent,
  children: b.children,
})).sort((a, b) => a.title.localeCompare(b.title));

const bySlug = new Map(all.map((b) => [b.slug, b]));

export const useBookStore = defineStore('books', () => {
  const books = all;
  function getBySlug (slug: string) {
    return bySlug.get(slug);
  }
  function getByJourney (j: string) {
    return all.filter((b) => b.journey === j);
  }
  return {
    books,
    getBySlug,
    getByJourney,
  };
});
