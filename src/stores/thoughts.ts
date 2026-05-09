import {
  defineStore,
} from 'pinia';
import {
  allThoughts,
} from 'content-collections';
import type {
  Thought,
} from '@/types/thought';

const all: Thought[] = allThoughts.map((thought) => ({
  slug: thought._meta.fileName.replace('.md', ''),
  createdAt: thought.createdAt ?? '',
  updatedAt: thought.updatedAt ?? '',
  title: thought.title,
  date: String(thought.date ?? ''),
  description: thought.description,
  tags: thought.tags,
  archived: thought.archived,
  concepts: thought.concepts,
  journeys: thought.journeys,
})).sort((first, second) => second.date.localeCompare(first.date));

const bySlug = new Map(all.map((thought) => [
  thought.slug,
  thought,
]));

export const useThoughtStore = defineStore('thoughts', () => {
  const thoughts = all.filter((thought) => !thought.archived);
  const archivedThoughts = all.filter((thought) => thought.archived);

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
