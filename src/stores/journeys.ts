import {
  defineStore,
} from 'pinia';
import {
  allJourneys,
} from 'content-collections';
import type {
  Journey,
} from '@/types/journey';

const STATUS_ORDER = {
  active: 0,
  paused: 1,
  completed: 2,
} as const;

const all: Journey[] = allJourneys.map((index) => ({
  slug: index._meta.fileName.replace('.md', ''),
  createdAt: index.createdAt ?? '',
  updatedAt: index.updatedAt ?? '',
  title: index.title,
  description: index.description,
  status: index.status as Journey['status'],
  tags: index.tags,
})).sort((first, second) => STATUS_ORDER[first.status] - STATUS_ORDER[second.status]);

const bySlug = new Map(all.map((index) => [
  index.slug,
  index,
]));

export const useJourneyStore = defineStore('journeys', () => {
  const journeys = all;
  function getBySlug (slug: string) {
    return bySlug.get(slug);
  }
  return {
    journeys,
    getBySlug,
  };
});
