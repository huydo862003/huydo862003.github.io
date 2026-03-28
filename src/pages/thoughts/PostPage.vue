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
        <Breadcrumb :crumbs="[{ label: 'Thoughts', to: '/thoughts' }]" />
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
      <PrevNextNav
        kind="thought"
        :prev="prevPost"
        :next="nextPost"
      />

      <GiscusComments />
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
import { useAsyncState } from '@vueuse/core';
import { useRoute } from 'vue-router';
import { useSeo } from '@/composables/use_seo';
import { useThoughtStore } from '@/stores/thoughts';
import { loadContent } from '@/utils/content';
import PrevNextNav from '@/components/PrevNextNav.vue';
import Breadcrumb from '@/components/BreadcrumbNav.vue';

const GiscusComments = defineAsyncComponent(() => import('@/components/GiscusComments.vue'));

const route = useRoute();
const thoughtStore = useThoughtStore();
const postSlug = computed(() => route.params.slug as string);
const post = computed(() => thoughtStore.getBySlug(postSlug.value));

useSeo({
  title: computed(() => post.value?.title),
  description: computed(() => post.value?.description),
  path: computed(() => `/thoughts/${postSlug.value}`),
});

const currentIdx = computed(() => thoughtStore.thoughts.findIndex((t) => t.slug === postSlug.value));
const prevPost = computed(() => {
  const t = thoughtStore.thoughts[currentIdx.value - 1];
  return t && {
    to: `/thoughts/${t.slug}`,
    title: t.title,
  };
});
const nextPost = computed(() => {
  const t = thoughtStore.thoughts[currentIdx.value + 1];
  return t && {
    to: `/thoughts/${t.slug}`,
    title: t.title,
  };
});
const {
  state: content, execute: reloadContent,
} = useAsyncState(async () => post.value ? loadContent(post.value.slug) : '', '');
watch(post, () => reloadContent());
</script>

<style scoped>
@reference "../../style.css";
h1 {
  @apply text-xl font-bold mb-1;
}
.meta {
  @apply text-xs text-fg-faint mb-8;
}
</style>
