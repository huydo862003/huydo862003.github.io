<template>
  <div class="page">
    <div class="top-bar">
      <router-link
        :to="`/journeys/${slug}/books`"
        class="back"
      >
        &larr; back to books
      </router-link>
      <SBreadcrumb :crumbs="[{ label: 'Journeys', to: '/journeys' }, { label: slug, to: `/journeys/${slug}` }, { label: 'Books', to: `/journeys/${slug}/books` }]" />
    </div>

    <template v-if="book">
      <div class="book-header">
        <img
          v-if="book.cover"
          :src="`/book-covers/${book.cover}`"
          :alt="book.title"
          class="book-cover"
        >
        <div class="book-header-meta">
          <h1>{{ book.title }}</h1>
          <p
            v-if="book.author"
            class="author"
          >
            {{ book.author }}
          </p>
          <p
            v-if="book.date"
            class="year"
          >
            {{ book.date }}
          </p>
          <div class="book-links">
            <a
              v-if="book.url"
              :href="book.url"
              target="_blank"
              rel="noopener"
              class="book-ext-link"
            >
              <PhArrowSquareOut :size="12" /> Publisher / Author page
            </a>
            <span
              v-if="book.isbn"
              class="book-isbn"
            >ISBN {{ book.isbn }}</span>
          </div>
          <p
            v-if="book.description && !book.parent"
            class="book-desc"
          >
            {{ book.description }}
          </p>
        </div>
      </div>

      <SCard
        v-if="rootBook"
        :data="rootBook"
        :config="bookConfig"
        class="mb-6"
      />

      <div
        v-if="book.concepts.length"
        class="section"
      >
        <div class="section-header">
          <h3 class="section-label">
            Concepts
          </h3>
          <input
            v-if="book.concepts.length > 10"
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
        kind="chapter"
        :prev="prevChapter && { to: `/journeys/${slug}/books/${prevChapter.slug}`, title: prevChapter.title }"
        :next="nextChapter && { to: `/journeys/${slug}/books/${nextChapter.slug}`, title: nextChapter.title }"
      />

      <GiscusComment />
    </template>
    <template v-else>
      <p>
        Not found. <router-link :to="`/journeys/${slug}/books`">
          Back to books
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
  PhBook, PhArrowSquareOut,
} from '@phosphor-icons/vue';
import {
  useSeo,
} from '@/composables/useSeo';
import {
  useBookStore,
} from '@/stores/books';
import {
  loadContent,
} from '@/utils/content';
import {
  formatSlug,
} from '@/utils/format';
import type {
  Book,
} from '@/types/book';
import SCard from '@/components/content/book/SCard.vue';
import type {
  SCardConfig,
} from '@/components/content/book/SCard.vue';
import ResourcePagination from '@/components/content/ResourcePagination.vue';
import SBreadcrumb from '@/components/common/SBreadcrumb.vue';

const GiscusComment = defineAsyncComponent(() => import('@/components/content/github/GiscusComment.vue'));

const PAGE_SIZE = 10;

const route = useRoute();
const slug = computed(() => route.params.slug as string);
const bookSlug = computed(() => route.params.bookSlug as string);
const bookStore = useBookStore();

const book = computed(() => bookStore.getBySlug(bookSlug.value));

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
  currentSlug: bookSlug.value,
  renderChildren: true,
}));

const BASE = 'https://huydo862003.github.io';
useSeo({
  title: computed(() => book.value?.title),
  description: computed(() => book.value?.description || (book.value?.author ? `By ${book.value.author}` : undefined)),
  path: computed(() => `/journeys/${slug.value}/books/${bookSlug.value}`),
  author: computed(() => book.value?.author),
  tags: computed(() => book.value?.tags),
  image: computed(() => book.value?.cover ? `${BASE}/book-covers/${book.value.cover}` : undefined),
  publishedTime: computed(() => book.value?.createdAt || undefined),
  modifiedTime: computed(() => book.value?.updatedAt || undefined),
});

const rootBook = computed(() => {
  let b = book.value;
  while (b?.parent) {
    const parent = bookStore.getBySlug(b.parent);
    if (!parent) break;
    b = parent;
  }
  return b;
});
const {
  state: content, execute: reloadContent,
} = useAsyncState(async () => book.value ? loadContent(book.value.slug) : '', '');
watch(book, () => reloadContent());

// Flat list of all books in this journey for prev/next navigation
const allJourneyBooks = computed(() => {
  if (!book.value) return [];
  const flat: Book[] = [];
  function collect (slugs: string[]) {
    for (const s of slugs) {
      const b = bookStore.getBySlug(s);
      if (b) {
        flat.push(b);
        if (b.children.length) collect(b.children);
      }
    }
  }
  const roots = bookStore.getByJourney(slug.value).filter((b) => !b.parent);
  collect(roots.map((b) => b.slug));
  return flat;
});

const currentIndex = computed(() => allJourneyBooks.value.findIndex((s) => s.slug === bookSlug.value));
const prevChapter = computed(() => allJourneyBooks.value[currentIndex.value - 1]);
const nextChapter = computed(() => allJourneyBooks.value[currentIndex.value + 1]);

const conceptSearch = ref('');
const conceptPage = ref(1);

const filteredConcepts = computed(() => {
  const all = book.value?.concepts ?? [];
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
  @apply text-xl font-bold mb-1;
}
.book-header {
  @apply flex gap-5 mb-6;
}
.book-cover {
  @apply w-24 shrink-0 rounded-sm object-cover self-start border border-border/50;
}
.book-header-meta {
  @apply flex flex-col min-w-0;
}
.author {
  @apply text-xs text-fg-faint mt-0.5;
}
.year {
  @apply text-xs text-fg-faint/60;
}
.book-links {
  @apply flex flex-wrap items-center gap-x-4 gap-y-0.5 mt-2 mb-2;
}
.book-ext-link {
  @apply inline-flex items-center gap-1 text-xs text-accent-blue no-underline hover:underline;
}
.book-isbn {
  @apply text-xs text-fg-faint/60 font-mono;
}
.book-desc {
  @apply text-xs text-fg-muted mt-1 max-w-prose;
}
.section {
  @apply mb-6;
}
.chapter-list {
  @apply list-none p-0 m-0 flex flex-col gap-0.5;
}
.chapter-list li {
  @apply border-l-2 border-border pl-3 py-1.5;
}
.sub-chapter-list {
  @apply list-none p-0 m-0 ml-3 mt-0.5 flex flex-col gap-0.5;
}
.sub-chapter-list li {
  @apply border-l border-border/50 pl-3 py-1;
}
.chapter-row {
  @apply flex items-center justify-between;
}
.chapter-link {
  @apply text-sm text-fg-muted no-underline hover:text-accent-blue transition-colors;
}
.sub-chapter-list .chapter-link {
  @apply text-xs;
}
.chapter-meta {
  @apply text-xs text-fg-faint;
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
