<template>
  <div class="page">
    <div class="top-bar">
      <router-link
        :to="`/journeys/${slug}/concepts`"
        class="back"
      >
        &larr; back to concepts
      </router-link>
      <SBreadcrumb :crumbs="[{ label: 'Journeys', to: '/journeys' }, { label: slug, to: `/journeys/${slug}` }, { label: 'Concepts', to: `/journeys/${slug}/concepts` }]" />
    </div>

    <template v-if="concept">
      <h1>{{ concept.title }}</h1>
      <div class="meta">
        <span
          v-tooltip="concept.status"
          class="status-ring"
          :style="{ '--progress': statusProgress(concept.status), '--ring-color': ringColor(statusProgress(concept.status)) }"
        />
        <span
          v-for="tag in displayTags"
          :key="tag"
          class="tag"
          :style="{ '--tag-hue': tagHue(tag) }"
        >{{ formatSlug(tag) }}</span>
      </div>

      <SCollapsible
        v-if="concept.books.length"
        label="Books"
        :columns="1"
        :items="bookItems"
      />

      <div class="section">
        <h3 class="section-label">
          Content
        </h3>
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
import { useAsyncState } from '@vueuse/core';
import { useRoute } from 'vue-router';
import { useSeo } from '@/composables/useSeo';
import { useConceptStore } from '@/stores/concepts';
import { loadContent } from '@/utils/content';
import {
  formatSlug, statusProgress, ringColor,
} from '@/utils/format';
import { tagHue } from '@/utils/color';
import SCollapsible from '@/components/common/SCollapsible.vue';
import ResourcePagination from '@/components/content/ResourcePagination.vue';
import SBreadcrumb from '@/components/common/SBreadcrumb.vue';

const GiscusComment = defineAsyncComponent(() => import('@/components/content/github/GiscusComment.vue'));

const route = useRoute();
const slug = computed(() => route.params.slug as string);
const conceptSlug = computed(() => route.params.conceptSlug as string);
const conceptStore = useConceptStore();

const concept = computed(() => conceptStore.getBySlug(conceptSlug.value));

useSeo({
  title: computed(() => concept.value?.title),
  description: computed(() => {
    const c = concept.value;
    if (!c) return undefined;
    if (c.description) return c.description;
    const parts: string[] = [`A ${c.status} concept in the ${slug.value} journey.`];
    if (c.tags.length) parts.push(`Topics: ${c.tags.join(', ')}.`);
    if (c.dependsOn.length) parts.push(`Builds on: ${c.dependsOn.join(', ')}.`);
    return parts.join(' ');
  }),
  tags: computed(() => {
    const c = concept.value;
    if (!c) return undefined;
    return [...c.tags, c.journey, c.status, 'concept', 'programming language theory'];
  }),
  path: computed(() => `/journeys/${slug.value}/concepts/${conceptSlug.value}`),
  publishedTime: computed(() => concept.value?.createdAt || undefined),
  modifiedTime: computed(() => concept.value?.updatedAt || undefined),
});

const journeyConcepts = computed(() => conceptStore.getByJourney(slug.value));
const currentIdx = computed(() => journeyConcepts.value.findIndex((c) => c.slug === conceptSlug.value));
const prevConcept = computed(() => {
  const c = journeyConcepts.value[currentIdx.value - 1];
  return c && {
    to: `/journeys/${slug.value}/concepts/${c.slug}`,
    title: c.title,
  };
});
const nextConcept = computed(() => {
  const c = journeyConcepts.value[currentIdx.value + 1];
  return c && {
    to: `/journeys/${slug.value}/concepts/${c.slug}`,
    title: c.title,
  };
});
const {
  state: content, execute: reloadContent,
} = useAsyncState(async () => concept.value ? loadContent(concept.value.slug) : '', '');
watch(concept, () => reloadContent());

const displayTags = computed(() =>
  (concept.value?.tags ?? []).filter((t) => t !== slug.value));

const bookItems = computed(() =>
  (concept.value?.books ?? []).map((b) => ({
    value: b,
    label: formatSlug(b),
    to: `/journeys/${slug.value}/books/${b}`,
  })));

</script>

<style scoped>
@reference "../../../style.css";
h1 {
  @apply text-xl font-bold mb-2;
}
.meta {
  @apply flex items-center gap-2 mb-6;
}
.tag {
  @apply inline-block text-xs font-semibold px-1.5 py-0.5 rounded;
  background: oklch(0.85 0.07 var(--tag-hue));
  color: oklch(0.38 0.1 var(--tag-hue));
}
:global(.dark) .tag {
  background: oklch(0.28 0.05 var(--tag-hue));
  color: oklch(0.82 0.06 var(--tag-hue));
}
.section {
  @apply mb-6;
}
</style>
