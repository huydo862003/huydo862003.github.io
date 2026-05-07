import {
  defineStore,
} from 'pinia';
import {
  allBooks,
} from 'content-collections';
import type {
  Book,
} from '@/types/book';

const all: Book[] = allBooks.map((book) => ({
  slug: book._meta.fileName.replace('.md', ''),
  createdAt: book.createdAt ?? '',
  updatedAt: book.updatedAt ?? '',
  title: book.title,
  author: book.author,
  date: String(book.date ?? ''),
  journey: book.journey,
  description: book.description ?? '',
  isbn: book.isbn ?? '',
  url: book.url ?? '',
  cover: book.cover ?? '',
  tags: book.tags,
  concepts: book.concepts,
  parent: book.parent,
  children: book.children,
})).sort((first, second) => first.title.localeCompare(second.title));

const bySlug = new Map(all.map((book) => [
  book.slug,
  book,
]));

export const useBookStore = defineStore('books', () => {
  const books = all;
  function getBySlug (slug: string) {
    return bySlug.get(slug);
  }
  function getByJourney (index: string) {
    return all.filter((book) => book.journey === index);
  }
  return {
    books,
    getBySlug,
    getByJourney,
  };
});
