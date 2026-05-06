<template>
  <div class="page">
    <div class="top-bar">
      <router-link
        :to="`/journeys/${slug}/papers`"
        class="back"
      >
        &larr; back to papers
      </router-link>
      <JourneyBreadcrumb :crumbs="[{ label: 'Journeys', to: '/journeys' }, { label: slug, to: `/journeys/${slug}` }, { label: 'Papers', to: `/journeys/${slug}/papers` }]" />
    </div>

    <template v-if="paper">
      <h1 class="text-xl font-bold mb-2">
        {{ paper.title }}
      </h1>

      <div class="flex flex-wrap items-center gap-x-2 gap-y-0.5 mb-3 text-xs text-fg-faint">
        <span v-if="paper.authors.length">{{ paper.authors.join(', ') }}</span>
        <template v-if="paper.venue || paper.year">
          <span class="text-fg-faint/50">&middot;</span>
          <span v-if="paper.venue">{{ paper.venue }}</span>
          <span
            v-if="paper.year"
            class="tabular-nums"
          >{{ paper.year }}</span>
        </template>
        <span :class="`status-${paper.status} ml-auto`">{{ paper.status }}</span>
      </div>

      <div
        v-if="paper.url"
        class="mb-4"
      >
        <a
          :href="paper.url"
          target="_blank"
          rel="noopener"
          class="inline-flex items-center gap-1 text-xs text-accent-blue no-underline hover:underline"
        >
          <GIcon
            :name="GIconName.ExternalLink"
            :size="13"
          /> Read paper
        </a>
      </div>

      <div
        v-if="paper.tags.length"
        class="flex flex-wrap gap-1 mb-6"
      >
        <GPill
          v-for="t in paper.tags"
          :key="t"
          :prominence="GProminence.Secondary"
          :size="GPillSize.Xs"
          :color="GPillColor.Gray"
        >
          {{ t }}
        </GPill>
      </div>

      <div class="mb-6">
        <h3 class="text-xs font-semibold text-fg-faint uppercase tracking-wider mb-3 pb-1 border-b border-border">
          Notes
        </h3>
        <div
          v-if="content"
          class="prose"
          v-html="content"
        />
        <p
          v-else
          class="text-sm text-fg-faint"
        >
          No notes yet.
        </p>
      </div>
    </template>
    <template v-else>
      <p>
        Not found. <router-link :to="`/journeys/${slug}/papers`">
          Back to papers
        </router-link>
      </p>
    </template>
  </div>
</template>

<script setup lang="ts">
import {
  computed, watch,
} from 'vue';
import {
  useAsyncState,
} from '@vueuse/core';
import {
  useRoute,
} from 'vue-router';
import {
  GIcon, GIconName, GPill, GPillColor, GPillSize, GProminence,
} from '@hdnax/genuix';
import {
  useSeo,
} from '@/composables/useSeo';
import {
  usePaperStore,
} from '@/stores/papers';
import {
  loadContent,
} from '@/utils/content';
import JourneyBreadcrumb from '@/components/common/JourneyBreadcrumb.vue';

const route = useRoute();
const slug = computed(() => route.params.slug as string);
const paperSlug = computed(() => route.params.paperSlug as string);
const paperStore = usePaperStore();

const paper = computed(() => paperStore.getBySlug(paperSlug.value));

useSeo({
  title: computed(() => paper.value?.title),
  description: computed(() => paper.value?.authors.length ? `By ${paper.value.authors.join(', ')}` : undefined),
  path: computed(() => `/journeys/${slug.value}/papers/${paperSlug.value}`),
});

const {
  state: content, execute: reloadContent,
} = useAsyncState(
  async () => paper.value ? loadContent(paper.value.slug) : '',
  '',
);
watch(paper, () => reloadContent());
</script>
