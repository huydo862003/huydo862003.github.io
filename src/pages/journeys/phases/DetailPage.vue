<template>
  <div class="page">
    <div class="top-bar">
      <router-link
        :to="`/journeys/${slug}/phases`"
        class="back"
      >
        &larr; back to phases
      </router-link>
      <JourneyBreadcrumb :crumbs="[{ label: 'Journeys', to: '/journeys' }, { label: slug, to: `/journeys/${slug}` }, { label: 'Phases', to: `/journeys/${slug}/phases` }]" />
    </div>

    <template v-if="phase">
      <div class="flex flex-wrap items-center gap-x-3 gap-y-1 mb-6">
        <h1 class="text-xl font-bold">
          {{ phase.title }}
        </h1>
        <span :class="`status-${phase.status}`">{{ phase.status }}</span>
      </div>

      <div
        v-if="content"
        class="prose mb-8"
        v-html="content"
      />
      <p
        v-else
        class="phase-empty text-sm"
      >
        No content yet.
      </p>

      <div
        v-if="rootBooks.length"
        class="mb-8"
      >
        <h2 class="phase-section-label text-xs font-semibold uppercase tracking-wider mb-3 pb-1 border-b">
          Books
        </h2>
        <div class="flex flex-col gap-3">
          <SCard
            v-for="b in rootBooks"
            :key="b.slug"
            :data="b"
            :config="bookConfig"
          />
        </div>
      </div>

      <div
        v-if="phase.concepts.length"
        class="mb-8"
      >
        <GFilterable
          label="Concepts"
          :columns="1"
          :page-size="PAGE_SIZE"
        >
          <template
            v-if="phase.concepts.length > 10"
            #search
          >
            <GFilterableSearchBox placeholder="Filter..." />
          </template>
          <GFilterableItem
            v-for="c in phase.concepts"
            :key="c"
            :value="c"
            :label="formatSlug(c)"
          >
            <router-link
              :to="`/journeys/${slug}/concepts/${c}`"
              class="phase-concept-link block text-sm no-underline truncate transition-colors py-1 border-b"
            >
              {{ formatSlug(c) }}
            </router-link>
          </GFilterableItem>
        </GFilterable>
      </div>

      <ResourcePagination
        kind="phase"
        :prev="previousPhase"
        :next="nextPhase"
      />

      <GiscusComment />
    </template>
    <template v-else>
      <p>
        Not found. <router-link :to="`/journeys/${slug}/phases`">
          Back to phases
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
  GIconName, GFilterable, GFilterableItem, GFilterableSearchBox,
} from '@hdnax/genuix';
import {
  useSeo,
} from '@/composables/useSeo';
import {
  usePhaseStore,
} from '@/stores/phases';
import {
  useBookStore,
} from '@/stores/books';
import SCard from '@/components/content/book/SCard.vue';
import type {
  SCardConfig,
} from '@/components/content/book/SCard.vue';
import type {
  Book,
} from '@/types/book';
import {
  loadContent,
} from '@/utils/content';
import {
  formatSlug,
} from '@/utils/format';
import ResourcePagination from '@/components/content/ResourcePagination.vue';
import JourneyBreadcrumb from '@/components/common/JourneyBreadcrumb.vue';

const GiscusComment = defineAsyncComponent(() => import('@/components/content/github/GiscusComment.vue'));

const PAGE_SIZE = 10;

const route = useRoute();
const slug = computed(() => route.params.slug as string);
const phaseSlug = computed(() => route.params.phaseSlug as string);
const phaseStore = usePhaseStore();
const bookStore = useBookStore();

const phase = computed(() => phaseStore.getBySlug(phaseSlug.value));

useSeo({
  title: computed(() => phase.value?.title),
  path: computed(() => `/journeys/${slug.value}/phases/${phaseSlug.value}`),
});

const journeyPhases = computed(() => phaseStore.getByJourney(slug.value));
const currentIndex = computed(() => journeyPhases.value.findIndex((phase) => phase.slug === phaseSlug.value));
const previousPhase = computed(() => {
  const phase = journeyPhases.value[currentIndex.value - 1];
  return phase && {
    to: `/journeys/${slug.value}/phases/${phase.slug}`,
    title: phase.title,
  };
});
const nextPhase = computed(() => {
  const phase = journeyPhases.value[currentIndex.value + 1];
  return phase && {
    to: `/journeys/${slug.value}/phases/${phase.slug}`,
    title: phase.title,
  };
});
const {
  state: content, execute: reloadContent,
} = useAsyncState(
  async () => phase.value ? loadContent(phase.value.slug) : '',
  '',
);
watch(phase, () => reloadContent());

const rootBooks = computed(() => {
  const seen = new Set<string>();
  const roots: NonNullable<ReturnType<typeof bookStore.getBySlug>>[] = [];
  for (const bookSlug of phase.value?.books ?? []) {
    let book = bookStore.getBySlug(bookSlug);
    if (!book) continue;
    while (book.parent) {
      const parent = bookStore.getBySlug(book.parent);
      if (!parent) break;
      book = parent;
    }
    if (!seen.has(book.slug)) {
      seen.add(book.slug);
      roots.push(book);
    }
  }
  return roots;
});

const bookConfig = computed((): SCardConfig<Book> => ({
  titleKey: 'title',
  icon: GIconName.Book,
  routeTemplate: '/journeys/{journeySlug}/books/{slug}',
  routeParams: {
    journeySlug: slug.value,
  },
  metaKeys: [
    'author',
    'date',
  ],
  childrenResolver: (book) => book.children
    .map((bookSlug) => bookStore.getBySlug(bookSlug))
    .filter((child): child is NonNullable<typeof child> => !!child),
  renderChildren: true,
}));

</script>

<style>
.phase-empty { color: var(--gui-neutral-solid); }
.phase-section-label { color: var(--gui-neutral-solid); border-color: var(--gui-neutral-border); }
.phase-concept-link { color: var(--gui-neutral-fg-muted); border-color: var(--gui-neutral-border); }
.phase-concept-link:hover { color: var(--gui-info-solid); }
</style>
