import {
  defineStore,
} from 'pinia';
import {
  allPapers,
} from 'content-collections';
import type {
  Paper,
} from '@/types/paper';

const all: Paper[] = allPapers.map((paper) => ({
  slug: paper._meta.fileName.replace('.md', ''),
  createdAt: paper.createdAt ?? '',
  updatedAt: paper.updatedAt ?? '',
  title: paper.title,
  authors: paper.authors,
  year: String(paper.year ?? ''),
  venue: paper.venue,
  url: paper.url,
  journey: paper.journey,
  tags: paper.tags,
  concepts: paper.concepts,
  status: paper.status,
})).sort((first, second) => first.title.localeCompare(second.title));

const bySlug = new Map(all.map((paper) => [
  paper.slug,
  paper,
]));

export const usePaperStore = defineStore('papers', () => {
  const papers = all;

  function getBySlug (slug: string) {
    return bySlug.get(slug);
  }

  function getByJourney (index: string) {
    return all.filter((paper) => paper.journey === index);
  }

  return {
    papers,
    getBySlug,
    getByJourney,
  };
});
