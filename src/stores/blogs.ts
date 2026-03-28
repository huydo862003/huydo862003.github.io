import { defineStore } from 'pinia';
import { allBlogs } from 'content-collections';
import type { Blog } from '@/types/blog';

const all: Blog[] = allBlogs.map((b) => ({
  slug: b._meta.fileName.replace('.md', ''),
  createdAt: b.createdAt ?? '',
  updatedAt: b.updatedAt ?? '',
  title: b.title,
  url: b.url,
  author: b.author,
  journey: b.journey,
  site: b.site,
  latestPost: b.latestPost,
  lastChecked: b.lastChecked,
  posts: b.posts,
  tags: b.tags,
})).sort((a, b) => a.title.localeCompare(b.title));

const bySlug = new Map(all.map((b) => [b.slug, b]));

export const useBlogs = defineStore('blogs', () => {
  const blogs = all;
  function getBySlug (slug: string) {
    return bySlug.get(slug);
  }
  function getByJourney (j: string) {
    return all.filter((b) => b.journey === j);
  }
  function getSites (j: string) {
    return all.filter((b) => b.journey === j && 0 < b.posts.length);
  }
  function getPosts (j: string) {
    return all.filter((b) => b.journey === j && b.posts.length === 0);
  }
  function getPostsBySite (s: string) {
    return all.filter((b) => b.site === s);
  }
  return {
    blogs,
    getBySlug,
    getByJourney,
    getSites,
    getPosts,
    getPostsBySite,
  };
});
