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

const all: Journey[] = allJourneys.map((j) => ({
  slug: j._meta.fileName.replace('.md', ''),
  createdAt: j.createdAt ?? '',
  updatedAt: j.updatedAt ?? '',
  title: j.title,
  description: j.description,
  status: j.status as Journey['status'],
  tags: j.tags,
})).sort((a, b) => STATUS_ORDER[a.status] - STATUS_ORDER[b.status]);

const bySlug = new Map(all.map((j) => [
  j.slug,
  j,
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
