import {
  defineStore,
} from 'pinia';
import {
  allConcepts,
} from 'content-collections';
import type {
  Concept,
} from '@/types/concept';

const all: Concept[] = allConcepts.map((concept) => ({
  slug: concept._meta.fileName.replace('.md', ''),
  createdAt: concept.createdAt,
  updatedAt: concept.updatedAt,
  title: concept.title,
  journey: concept.journey,
  description: concept.description ?? '',
  status: concept.status as Concept['status'],
  tags: concept.tags,
  books: concept.books,
  dependsOn: concept.dependsOn,
  blocks: concept.blocks,
})).sort((first, second) => first.title.localeCompare(second.title));

const bySlug = new Map(all.map((concept) => [
  concept.slug,
  concept,
]));

export const useConceptStore = defineStore('concepts', () => {
  const concepts = all;

  function getBySlug (slug: string) {
    return bySlug.get(slug);
  }

  function getByJourney (index: string) {
    return all.filter((concept) => concept.journey === index);
  }

  function statsByJourney (index?: string) {
    const pool = index ? getByJourney(index) : all;
    const counts = {
      total: pool.length,
      learning: 0,
      reviewing: 0,
      mastered: 0,
    };

    for (const concept of pool) counts[concept.status]++;

    return counts;
  }

  return {
    concepts,
    getBySlug,
    getByJourney,
    statsByJourney,
  };
});
