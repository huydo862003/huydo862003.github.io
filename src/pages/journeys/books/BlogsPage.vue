<template>
  <div class="page">
    <div class="top-bar">
      <router-link
        :to="`/journeys/${slug}`"
        class="back"
      >
        &larr; back to journey
      </router-link>
      <SBreadcrumb :crumbs="[{ label: 'Journeys', to: '/journeys' }, { label: slug, to: `/journeys/${slug}` }, { label: 'Blogs', to: `/journeys/${slug}/blogs` }]" />
    </div>
    <h1>Blogs</h1>

    <div
      v-if="sites.length"
      class="section"
    >
      <h2 class="section-label">
        Sites
      </h2>
      <div
        v-for="site in sites"
        :key="site.slug"
        class="site"
      >
        <div class="site-header">
          <a
            v-if="site.url"
            :href="site.url"
            target="_blank"
            rel="noopener"
            class="site-title"
          >{{ site.title }}</a>
          <span
            v-else
            class="site-title"
          >{{ site.title }}</span>
          <span
            v-if="site.author"
            class="site-author"
          > - {{ site.author }}</span>
        </div>
        <ul
          v-if="sitePosts(site.slug).length"
          class="post-list"
        >
          <li
            v-for="post in sitePosts(site.slug)"
            :key="post.slug"
            class="post"
          >
            <a
              v-if="post.url"
              :href="post.url"
              target="_blank"
              rel="noopener"
              class="post-link"
            >{{ post.title }}</a>
            <span v-else>{{ post.title }}</span>
          </li>
        </ul>
      </div>
    </div>

    <div
      v-if="standalonePosts.length"
      class="section"
    >
      <h2 class="section-label">
        Posts
      </h2>
      <ul class="post-list standalone">
        <li
          v-for="post in standalonePosts"
          :key="post.slug"
          class="post"
        >
          <a
            v-if="post.url"
            :href="post.url"
            target="_blank"
            rel="noopener"
            class="post-link"
          >{{ post.title }}</a>
          <span v-else>{{ post.title }}</span>
          <span
            v-if="post.author"
            class="post-author"
          >{{ post.author }}</span>
        </li>
      </ul>
    </div>

    <p
      v-if="!sites.length && !standalonePosts.length"
      class="empty"
    >
      No blogs yet.
    </p>
  </div>
</template>

<script setup lang="ts">
import { computed } from 'vue';
import { useRoute } from 'vue-router';
import SBreadcrumb from '@/components/common/SBreadcrumb.vue';
import { useBlogs } from '@/stores/blogs';

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

<style scoped>
@reference "../../../style.css";

h1 {
  @apply text-xl font-bold mb-6;
}
.section {
  @apply mb-6;
}
.site {
  @apply mb-4;
}
.site-header {
  @apply flex flex-wrap items-center gap-1 mb-1;
}
.site-title {
  @apply text-sm font-medium text-accent-blue no-underline hover:underline;
}
.site-author {
  @apply text-xs text-fg-faint;
}
.post-list {
  @apply list-none p-0 m-0 ml-4 flex flex-col;
}
.post-list.standalone {
  @apply ml-0;
}
.post {
  @apply flex items-center justify-between border-l-2 border-border pl-3 py-1.5
         text-sm text-fg-muted;
}
.post-link {
  @apply text-fg-muted no-underline hover:text-accent-blue transition-colors;
}
.post-author {
  @apply text-xs text-fg-faint;
}
.empty {
  @apply text-fg-faint text-sm;
}
</style>
