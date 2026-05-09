import {
  defineStore,
} from 'pinia';
import {
  allBlogs, allBlogsites,
} from 'content-collections';
import type {
  BlogPost, BlogSite,
} from '@/types/blog';

const posts: BlogPost[] = allBlogs.map((post) => ({
  slug: post._meta.fileName.replace('.md', ''),
  createdAt: post.createdAt ?? '',
  updatedAt: post.updatedAt ?? '',
  title: post.title,
  url: post.url,
  author: post.author ?? '',
  journey: post.journey,
  site: post.site ?? '',
  tags: post.tags ?? [],
})).sort((first, second) => first.title.localeCompare(second.title));

const sites: BlogSite[] = allBlogsites.map((site) => ({
  slug: site._meta.fileName.replace('.md', ''),
  createdAt: site.createdAt ?? '',
  updatedAt: site.updatedAt ?? '',
  title: site.title,
  url: site.url,
  author: site.author ?? '',
  journey: site.journey,
  latestPost: site.latestPost ?? '',
  lastChecked: site.lastChecked ?? '',
  posts: site.posts ?? [],
})).sort((first, second) => first.title.localeCompare(second.title));

const postsBySlug = new Map(posts.map((post) => [
  post.slug,
  post,
]));
const sitesBySlug = new Map(sites.map((site) => [
  site.slug,
  site,
]));

export const useBlogStore = defineStore('blogs', () => {
  function getPostBySlug (slug: string) {
    return postsBySlug.get(slug);
  }

  function getSiteBySlug (slug: string) {
    return sitesBySlug.get(slug);
  }

  function getByJourney (index: string) {
    return posts.filter((post) => post.journey === index);
  }

  function getSites (index: string) {
    return sites.filter((site) => site.journey === index);
  }

  function getPosts (index: string) {
    return posts.filter((post) => post.journey === index);
  }

  function getPostsBySite (siteSlug: string) {
    return posts.filter((post) => post.site === siteSlug);
  }

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
