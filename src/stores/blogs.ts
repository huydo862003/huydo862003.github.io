import { defineStore } from 'pinia';
import { allBlogs, allBlogsites } from 'content-collections';
import type { BlogPost, BlogSite } from '@/types/blog';

const posts: BlogPost[] = allBlogs.map((b) => ({
  slug: b._meta.fileName.replace('.md', ''),
  createdAt: b.createdAt ?? '',
  updatedAt: b.updatedAt ?? '',
  title: b.title,
  url: b.url,
  author: b.author ?? '',
  journey: b.journey,
  site: b.site ?? '',
  tags: b.tags ?? [],
})).sort((a, b) => a.title.localeCompare(b.title));

const sites: BlogSite[] = allBlogsites.map((b) => ({
  slug: b._meta.fileName.replace('.md', ''),
  createdAt: b.createdAt ?? '',
  updatedAt: b.updatedAt ?? '',
  title: b.title,
  url: b.url,
  author: b.author ?? '',
  journey: b.journey,
  latestPost: b.latestPost ?? '',
  lastChecked: b.lastChecked ?? '',
  posts: b.posts ?? [],
})).sort((a, b) => a.title.localeCompare(b.title));

const postsBySlug = new Map(posts.map((p) => [p.slug, p]));
const sitesBySlug = new Map(sites.map((s) => [s.slug, s]));

export const useBlogs = defineStore('blogs', () => {
  function getPostBySlug (slug: string) { return postsBySlug.get(slug); }
  function getSiteBySlug (slug: string) { return sitesBySlug.get(slug); }
  function getByJourney (j: string) { return posts.filter((p) => p.journey === j); }
  function getSites (j: string) { return sites.filter((s) => s.journey === j); }
  function getPosts (j: string) { return posts.filter((p) => p.journey === j); }
  function getPostsBySite (s: string) { return posts.filter((p) => p.site === s); }

  return {
    posts,
    sites,
    getPostBySlug,
    getSiteBySlug,
    getByJourney,
    getSites,
    getPosts,
    getPostsBySite,
  };
});
