import {
  defineStore,
} from 'pinia';
import {
  allConcepts,
} from 'content-collections';
import type {
  Concept,
} from '@/types/concept';

const all: Concept[] = allConcepts.map((c) => ({
  slug: c._meta.fileName.replace('.md', ''),
  createdAt: c.createdAt,
  updatedAt: c.updatedAt,
  title: c.title,
  journey: c.journey,
  description: c.description ?? '',
  status: c.status as Concept['status'],
  tags: c.tags,
  keywords: c.keywords ?? [
  ],
  books: c.books,
  dependsOn: c.dependsOn,
  blocks: c.blocks,
})).sort((a, b) => a.title.localeCompare(b.title));

const bySlug = new Map(all.map((c) => [
  c.slug,
  c,
]));

export const useConceptStore = defineStore('concepts', () => {
  const concepts = all;
  function getBySlug (slug: string) {
    return bySlug.get(slug);
  }
  function getByJourney (j: string) {
    return all.filter((c) => c.journey === j);
  }
  function statsByJourney (j?: string) {
    const pool = j ? getByJourney(j) : all;
    const counts = {
      total: pool.length,
      learning: 0,
      reviewing: 0,
      mastered: 0,
    };
    for (const c of pool) counts[c.status]++;
    return counts;
  }
  return {
    concepts,
    getBySlug,
    getByJourney,
    statsByJourney,
  };
});
