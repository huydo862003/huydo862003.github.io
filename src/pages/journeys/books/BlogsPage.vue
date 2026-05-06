<template>
  <div class="page">
    <div class="top-bar">
      <router-link
        :to="`/journeys/${slug}`"
        class="back"
      >
        &larr; back to journey
      </router-link>
      <JourneyBreadcrumb :crumbs="[{ label: 'Journeys', to: '/journeys' }, { label: slug, to: `/journeys/${slug}` }, { label: 'Blogs', to: `/journeys/${slug}/blogs` }]" />
    </div>
    <h1 class="text-xl font-bold mb-6">
      Blogs
    </h1>

    <div
      v-if="sites.length"
      class="mb-6"
    >
      <h2 class="blogs-section-label text-xs font-semibold uppercase tracking-wider mb-3 pb-1 border-b">
        Sites
      </h2>
      <div
        v-for="site in sites"
        :key="site.slug"
        class="mb-4"
      >
        <div class="flex flex-wrap items-center gap-1 mb-1">
          <a
            v-if="site.url"
            :href="site.url"
            target="_blank"
            rel="noopener"
            class="blogs-site-link text-sm font-medium no-underline hover:underline"
          >{{ site.title }}</a>
          <span
            v-else
            class="blogs-site-link text-sm font-medium"
          >{{ site.title }}</span>
          <span
            v-if="site.author"
            class="blogs-author text-xs"
          > - {{ site.author }}</span>
        </div>
        <ul
          v-if="sitePosts(site.slug).length"
          class="list-none p-0 m-0 ml-4 flex flex-col"
        >
          <li
            v-for="post in sitePosts(site.slug)"
            :key="post.slug"
            class="blogs-post-item flex items-center justify-between border-l-2 pl-3 py-1.5 text-sm"
          >
            <a
              v-if="post.url"
              :href="post.url"
              target="_blank"
              rel="noopener"
              class="blogs-post-link no-underline transition-colors"
            >{{ post.title }}</a>
            <span v-else>{{ post.title }}</span>
          </li>
        </ul>
      </div>
    </div>

    <div
      v-if="standalonePosts.length"
      class="mb-6"
    >
      <h2 class="blogs-section-label text-xs font-semibold uppercase tracking-wider mb-3 pb-1 border-b">
        Posts
      </h2>
      <ul class="list-none p-0 m-0 flex flex-col">
        <li
          v-for="post in standalonePosts"
          :key="post.slug"
          class="blogs-post-item flex items-center justify-between border-l-2 pl-3 py-1.5 text-sm"
        >
          <a
            v-if="post.url"
            :href="post.url"
            target="_blank"
            rel="noopener"
            class="blogs-post-link no-underline transition-colors"
          >{{ post.title }}</a>
          <span v-else>{{ post.title }}</span>
          <span
            v-if="post.author"
            class="blogs-author text-xs"
          >{{ post.author }}</span>
        </li>
      </ul>
    </div>

    <p
      v-if="!sites.length && !standalonePosts.length"
      class="blogs-empty text-sm"
    >
      No blogs yet.
    </p>
  </div>
</template>

<script setup lang="ts">
import {
  computed,
} from 'vue';
import {
  useRoute,
} from 'vue-router';
import JourneyBreadcrumb from '@/components/common/JourneyBreadcrumb.vue';
import {
  useBlogs,
} from '@/stores/blogs';

const route = useRoute();
const slug = computed(() => route.params.slug as string);
const blogStore = useBlogs();

const sites = computed(() => blogStore.getSites(slug.value));
const standalonePosts = computed(() =>
  blogStore.getPosts(slug.value).filter((p) => !p.site));

function sitePosts (siteSlug: string) {
  return blogStore.getPostsBySite(siteSlug);
}
</script>

<style>
.blogs-section-label { color: var(--gui-neutral-solid); border-color: var(--gui-neutral-border); }
.blogs-site-link { color: var(--gui-info-solid); }
.blogs-author { color: var(--gui-neutral-solid); }
.blogs-post-item { color: var(--gui-neutral-fg-muted); border-color: var(--gui-neutral-border); }
.blogs-post-link { color: var(--gui-neutral-fg-muted); }
.blogs-post-link:hover { color: var(--gui-info-solid); }
.blogs-empty { color: var(--gui-neutral-solid); }
</style>
