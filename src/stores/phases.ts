import { defineStore } from 'pinia';
import { allPhases } from 'content-collections';
import type { Phase } from '@/types/phase';

const all: Phase[] = allPhases.map((p) => ({
  slug: p._meta.fileName.replace('.md', ''),
  createdAt: p.createdAt ?? '',
  updatedAt: p.updatedAt ?? '',
  title: p.title,
  journey: p.journey,
  status: p.status as Phase['status'],
  order: p.order,
  books: p.books,
  concepts: p.concepts,
})).sort((a, b) => a.order - b.order);

const bySlug = new Map(all.map((p) => [p.slug, p]));

export const usePhaseStore = defineStore('phases', () => {
  const phases = all;
  function getBySlug (slug: string) {
    return bySlug.get(slug);
  }
  function getByJourney (j: string) {
    return all.filter((p) => p.journey === j);
  }
  return {
    phases,
    getBySlug,
    getByJourney,
  };
});
