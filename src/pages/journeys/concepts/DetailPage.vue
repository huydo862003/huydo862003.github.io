<template>
  <div class="page">
    <div class="top-bar">
      <router-link
        :to="`/journeys/${slug}/concepts`"
        class="back"
      >
        &larr; back to concepts
      </router-link>
      <JourneyBreadcrumb :crumbs="[{ label: 'Journeys', to: '/journeys' }, { label: slug, to: `/journeys/${slug}` }, { label: 'Concepts', to: `/journeys/${slug}/concepts` }]" />
    </div>

    <template v-if="concept">
      <h1 class="text-xl font-bold mb-2">
        {{ concept.title }}
      </h1>
      <div class="flex items-center gap-2 mb-6">
        <span
          v-tooltip="concept.status"
          class="status-ring"
          :style="{ '--progress': statusProgress(concept.status), '--ring-color': ringColor(statusProgress(concept.status)) }"
        />
        <GPill
          v-for="tag in displayTags"
          :key="tag"
          :prominence="GProminence.Secondary"
          :size="GPillSize.Xs"
          :color="GPillColor.Gray"
        >
          {{ formatSlug(tag) }}
        </GPill>
      </div>

      <GFilterable
        v-if="concept.books.length"
        label="Books"
        :columns="1"
        :items="bookItems"
      />

      <div class="mb-6">
        <h3 class="concept-detail-label text-xs font-semibold uppercase tracking-wider mb-3 pb-1 border-b">
          Content
        </h3>
        <div
          v-if="content"
          class="prose"
          v-html="content"
        />
        <p
          v-else
          class="concept-detail-empty text-sm"
        >
          No content yet.
        </p>
      </div>

      <ResourcePagination
        kind="concept"
        :prev="prevConcept"
        :next="nextConcept"
      />

      <GiscusComment />
    </template>
    <template v-else>
      <p>
        Not found. <router-link :to="`/journeys/${slug}/concepts`">
          Back to concepts
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
  useRoute, RouterLink,
} from 'vue-router';
import {
  GFilterable, GPill, GPillColor, GPillSize, GProminence,
} from '@hdnax/genuix';
import {
  useSeo,
} from '@/composables/useSeo';
import {
  useConceptStore,
} from '@/stores/concepts';
import {
  loadContent,
} from '@/utils/content';
import {
  formatSlug, statusProgress, ringColor,
} from '@/utils/format';
import ResourcePagination from '@/components/content/ResourcePagination.vue';
import JourneyBreadcrumb from '@/components/common/JourneyBreadcrumb.vue';

const GiscusComment = defineAsyncComponent(() => import('@/components/content/github/GiscusComment.vue'));

const route = useRoute();
const slug = computed(() => route.params.slug as string);
const conceptSlug = computed(() => route.params.conceptSlug as string);
const conceptStore = useConceptStore();

const concept = computed(() => conceptStore.getBySlug(conceptSlug.value));

useSeo({
  title: computed(() => concept.value?.title),
  description: computed(() => {
    const currentConcept = concept.value;
    if (!currentConcept) return undefined;
    if (currentConcept.description) return currentConcept.description;
    const parts: string[] = [`A ${currentConcept.status} concept in the ${slug.value} journey.`];
    if (currentConcept.tags.length) parts.push(`Topics: ${currentConcept.tags.join(', ')}.`);
    if (currentConcept.dependsOn.length) parts.push(`Builds on: ${currentConcept.dependsOn.join(', ')}.`);
    return parts.join(' ');
  }),
  tags: computed(() => {
    const currentConcept = concept.value;
    if (!currentConcept) return undefined;
    return [
      ...currentConcept.tags,
      currentConcept.journey,
      currentConcept.status,
      'concept',
      'programming language theory',
    ];
  }),
  path: computed(() => `/journeys/${slug.value}/concepts/${conceptSlug.value}`),
  publishedTime: computed(() => concept.value?.createdAt || undefined),
  modifiedTime: computed(() => concept.value?.updatedAt || undefined),
});

const journeyConcepts = computed(() => conceptStore.getByJourney(slug.value));
const currentIdx = computed(() => journeyConcepts.value.findIndex((c) => c.slug === conceptSlug.value));
const prevConcept = computed(() => {
  const prev = journeyConcepts.value[currentIdx.value - 1];
  return prev && {
    to: `/journeys/${slug.value}/concepts/${prev.slug}`,
    title: prev.title,
  };
});
const nextConcept = computed(() => {
  const next = journeyConcepts.value[currentIdx.value + 1];
  return next && {
    to: `/journeys/${slug.value}/concepts/${next.slug}`,
    title: next.title,
  };
});
const {
  state: content, execute: reloadContent,
} = useAsyncState(
  async () => concept.value ? loadContent(concept.value.slug) : '',
  '',
);
watch(concept, () => reloadContent());

const displayTags = computed(() =>
  (concept.value?.tags ?? []).filter((t) => t !== slug.value));

const bookItems = computed(() =>
  (concept.value?.books ?? []).map((b) => ({
    value: b,
    label: formatSlug(b),
    to: `/journeys/${slug.value}/books/${b}`,
    as: RouterLink,
  })));
</script>

<style>
.concept-detail-label { color: var(--gui-neutral-solid); border-color: var(--gui-neutral-border); }
.concept-detail-empty { color: var(--gui-neutral-solid); }
</style>
