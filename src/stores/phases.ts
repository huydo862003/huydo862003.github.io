import {
  defineStore,
} from 'pinia';
import {
  allPhases,
} from 'content-collections';
import type {
  Phase,
} from '@/types/phase';

const all: Phase[] = allPhases.map((phase) => ({
  slug: phase._meta.fileName.replace('.md', ''),
  createdAt: phase.createdAt ?? '',
  updatedAt: phase.updatedAt ?? '',
  title: phase.title,
  journey: phase.journey,
  status: phase.status as Phase['status'],
  order: phase.order,
  books: phase.books,
  concepts: phase.concepts,
})).sort((first, second) => first.order - second.order);

const bySlug = new Map(all.map((phase) => [
  phase.slug,
  phase,
]));

export const usePhaseStore = defineStore('phases', () => {
  const phases = all;

  function getBySlug (slug: string) {
    return bySlug.get(slug);
  }

  function getByJourney (index: string) {
    return all.filter((phase) => phase.journey === index);
  }

  return {
    phases,
    getBySlug,
    getByJourney,
  };
});
