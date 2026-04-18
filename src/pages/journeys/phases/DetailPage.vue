<template>
  <div class="page">
    <div class="top-bar">
      <router-link
        :to="`/journeys/${slug}/phases`"
        class="back"
      >
        &larr; back to phases
      </router-link>
      <SBreadcrumb :crumbs="[{ label: 'Journeys', to: '/journeys' }, { label: slug, to: `/journeys/${slug}` }, { label: 'Phases', to: `/journeys/${slug}/phases` }]" />
    </div>

    <template v-if="phase">
      <div class="title-row">
        <h1>{{ phase.title }}</h1>
        <span :class="`status-${phase.status}`">{{ phase.status }}</span>
      </div>

      <div
        v-if="content"
        class="prose mb-8"
        v-html="content"
      />
      <p
        v-else
        class="empty"
      >
        No content yet.
      </p>

      <div
        v-if="rootBooks.length"
        class="section"
      >
        <h2 class="section-label">
          Books
        </h2>
        <div class="book-cards">
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
        class="section"
      >
        <div class="section-header">
          <h2 class="section-label">
            Concepts
          </h2>
          <input
            v-if="phase.concepts.length > 10"
            v-model="conceptSearch"
            type="text"
            placeholder="Filter..."
            class="filter-input"
          >
          <span
            v-if="conceptSearch"
            class="section-count"
          >{{ filteredConcepts.length }} results</span>
        </div>
        <ul class="concept-list">
          <li
            v-for="c in pagedConcepts"
            :key="c"
          >
            <router-link
              :to="`/journeys/${slug}/concepts/${c}`"
              class="concept-link"
            >
              {{ formatSlug(c) }}
            </router-link>
          </li>
        </ul>
        <div
          v-if="conceptPages > 1"
          class="paging"
        >
          <button
            :disabled="conceptPage <= 1"
            class="page-btn"
            @click="conceptPage--"
          >
            &larr;
          </button>
          <span class="page-info">{{ conceptPage }} / {{ conceptPages }}</span>
          <button
            :disabled="conceptPage >= conceptPages"
            class="page-btn"
            @click="conceptPage++"
          >
            &rarr;
          </button>
        </div>
      </div>

      <ResourcePagination
        kind="phase"
        :prev="prevPhase"
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
  ref, computed, watch, defineAsyncComponent,
} from 'vue';
import {
  useAsyncState,
} from '@vueuse/core';
import {
  useRoute,
} from 'vue-router';
import {
  PhBook,
} from '@phosphor-icons/vue';
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
import SBreadcrumb from '@/components/common/SBreadcrumb.vue';

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
const currentIdx = computed(() => journeyPhases.value.findIndex((p) => p.slug === phaseSlug.value));
const prevPhase = computed(() => {
  const p = journeyPhases.value[currentIdx.value - 1];
  return p && {
    to: `/journeys/${slug.value}/phases/${p.slug}`,
    title: p.title,
  };
});
const nextPhase = computed(() => {
  const p = journeyPhases.value[currentIdx.value + 1];
  return p && {
    to: `/journeys/${slug.value}/phases/${p.slug}`,
    title: p.title,
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
  for (const s of phase.value?.books ?? []) {
    let b = bookStore.getBySlug(s);
    if (!b) continue;
    while (b.parent) {
      const p = bookStore.getBySlug(b.parent);
      if (!p) break;
      b = p;
    }
    if (!seen.has(b.slug)) {
      seen.add(b.slug);
      roots.push(b);
    }
  }
  return roots;
});

const bookConfig = computed((): SCardConfig<Book> => ({
  titleKey: 'title',
  icon: PhBook,
  routeTemplate: '/journeys/{journeySlug}/books/{slug}',
  routeParams: {
    journeySlug: slug.value,
  },
  metaKeys: [
    'author',
    'date',
  ],
  childrenResolver: (book) => book.children
    .map((s) => bookStore.getBySlug(s))
    .filter((c): c is NonNullable<typeof c> => !!c),
  renderChildren: true,
}));

const conceptSearch = ref('');
const conceptPage = ref(1);

const filteredConcepts = computed(() => {
  const all = phase.value?.concepts ?? [];
  if (!conceptSearch.value) return all;
  const q = conceptSearch.value.toLowerCase();
  return all.filter((c) => c.toLowerCase().includes(q));
});

const conceptPages = computed(() => Math.max(1, Math.ceil(filteredConcepts.value.length / PAGE_SIZE)));

const pagedConcepts = computed(() => {
  const start = (conceptPage.value - 1) * PAGE_SIZE;
  return filteredConcepts.value.slice(start, start + PAGE_SIZE);
});

watch(conceptSearch, () => {
  conceptPage.value = 1;
});
</script>

<style scoped>
@reference "../../../style.css";
h1 {
  @apply text-xl font-bold;
}
.title-row {
  @apply flex flex-wrap items-center gap-x-3 gap-y-1 mb-6;
}
.section {
  @apply mb-8;
}
.section-header {
  @apply flex items-baseline gap-2 mb-3;
}
.section-count {
  @apply text-xs text-fg-faint ml-auto;
}
.filter-input {
  @apply text-xs px-2 py-1 bg-transparent text-fg border border-border
         rounded-sm outline-none w-28 placeholder:text-fg-faint/40
         focus:border-fg-faint transition-colors;
}
.book-cards {
  @apply flex flex-col gap-3;
}
.concept-list {
  @apply list-none p-0 m-0;
}
.concept-list li {
  @apply py-1 border-b border-border;
}
.concept-link {
  @apply block text-sm text-fg-muted no-underline hover:text-accent-blue
         truncate transition-colors;
}
.paging {
  @apply flex items-center justify-center gap-3 mt-4;
}
.page-btn {
  @apply text-sm px-2 py-1 border border-border rounded-sm text-fg-muted
         hover:border-fg-faint transition-colors cursor-pointer
         disabled:opacity-30 disabled:cursor-default;
}
.page-info {
  @apply text-xs text-fg-faint;
}
</style>
