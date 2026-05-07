<template>
  <div class="page">
    <template v-if="post">
      <div class="top-bar">
        <router-link
          to="/thoughts"
          class="back"
        >
          &larr; all thoughts
        </router-link>
        <JourneyBreadcrumb :crumbs="[{ label: 'Thoughts', to: '/thoughts' }]" />
      </div>
      <article>
        <h1>{{ post.title }}</h1>
        <p class="meta">
          {{ post.date }}
        </p>
        <div
          v-if="content"
          class="prose"
          v-html="content"
        />
        <p
          v-else
          class="empty"
        >
          No content yet.
        </p>
      </article>
      <ResourcePagination
        kind="thought"
        :prev="previousPost"
        :next="nextPost"
      />

      <GiscusComment />
    </template>
    <template v-else>
      <p>
        Not found. <router-link to="/thoughts">
          Back to thoughts
        </router-link>
      </p>
    </template>
  </div>
</template>

<script setup lang="ts">
import {
  computed, watch, defineAsyncComponent,
} from 'vue';
import {
  useAsyncState,
} from '@vueuse/core';
import {
  useRoute,
} from 'vue-router';
import {
  useSeo,
} from '@/composables/useSeo';
import {
  useThoughtStore,
} from '@/stores/thoughts';
import {
  loadContent,
} from '@/utils/content';
import ResourcePagination from '@/components/content/ResourcePagination.vue';
import JourneyBreadcrumb from '@/components/common/JourneyBreadcrumb.vue';

const GiscusComment = defineAsyncComponent(() => import('@/components/content/github/GiscusComment.vue'));

const route = useRoute();
const thoughtStore = useThoughtStore();
const postSlug = computed(() => route.params.slug as string);
const post = computed(() => thoughtStore.getBySlug(postSlug.value));

useSeo({
  title: computed(() => post.value?.title),
  description: computed(() => post.value?.description),
  path: computed(() => `/thoughts/${postSlug.value}`),
});

const currentIndex = computed(() => thoughtStore.thoughts.findIndex((thought) => thought.slug === postSlug.value));
const previousPost = computed(() => {
  const thought = thoughtStore.thoughts[currentIndex.value - 1];
  return thought && {
    to: `/thoughts/${thought.slug}`,
    title: thought.title,
  };
});
const nextPost = computed(() => {
  const thought = thoughtStore.thoughts[currentIndex.value + 1];
  return thought && {
    to: `/thoughts/${thought.slug}`,
    title: thought.title,
  };
});
const {
  state: content, execute: reloadContent,
} = useAsyncState(async () => post.value ? loadContent(post.value.slug) : '', '');
watch(post, () => reloadContent());
</script>

<style scoped>
@reference "@/style.css";
h1 {
  @apply text-xl font-bold mb-1;
}
.meta {
  @apply text-xs mb-8;
  color: var(--gui-neutral-solid);
}
</style>
