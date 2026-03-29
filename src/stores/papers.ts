import { defineStore } from 'pinia';
import { allPapers } from 'content-collections';
import type { Paper } from '@/types/paper';

const all: Paper[] = allPapers.map((p) => ({
  slug: p._meta.fileName.replace('.md', ''),
  createdAt: p.createdAt ?? '',
  updatedAt: p.updatedAt ?? '',
  title: p.title,
  authors: p.authors,
  year: String(p.year ?? ''),
  venue: p.venue,
  url: p.url,
  journey: p.journey,
  tags: p.tags,
  concepts: p.concepts,
  status: p.status,
})).sort((a, b) => a.title.localeCompare(b.title));

const bySlug = new Map(all.map((p) => [p.slug, p]));

export const usePaperStore = defineStore('papers', () => {
  const papers = all;
  function getBySlug (slug: string) {
    return bySlug.get(slug);
  }
  function getByJourney (j: string) {
    return all.filter((p) => p.journey === j);
  }
  return {
    papers,
    getBySlug,
    getByJourney,
  };
});
