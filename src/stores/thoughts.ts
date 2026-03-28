import { defineStore } from 'pinia';
import { allThoughts } from 'content-collections';
import type { Thought } from '@/types/thought';

const all: Thought[] = allThoughts.map((t) => ({
  slug: t._meta.fileName.replace('.md', ''),
  createdAt: t.createdAt ?? '',
  updatedAt: t.updatedAt ?? '',
  title: t.title,
  date: String(t.date ?? ''),
  description: t.description,
  tags: t.tags,
  archived: t.archived,
  concepts: t.concepts,
  journeys: t.journeys,
})).sort((a, b) => b.date.localeCompare(a.date));

const bySlug = new Map(all.map((t) => [t.slug, t]));

export const useThoughtStore = defineStore('thoughts', () => {
  const thoughts = all.filter((t) => !t.archived);
  const archivedThoughts = all.filter((t) => t.archived);
  function getBySlug (slug: string) {
    return bySlug.get(slug);
  }
  function getRecent (n: number) {
    return thoughts.slice(0, n);
  }
  return {
    thoughts,
    archivedThoughts,
    getBySlug,
    getRecent,
  };
});
