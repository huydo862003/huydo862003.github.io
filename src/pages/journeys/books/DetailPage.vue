<template>
  <div class="page">
    <div class="top-bar">
      <router-link
        :to="`/journeys/${slug}/books`"
        class="back"
      >
        &larr; back to books
      </router-link>
      <JourneyBreadcrumb :crumbs="[{ label: 'Journeys', to: '/journeys' }, { label: slug, to: `/journeys/${slug}` }, { label: 'Books', to: `/journeys/${slug}/books` }]" />
    </div>

    <template v-if="book">
      <div class="flex gap-5 mb-6">
        <img
          v-if="book.cover"
          :src="`/book-covers/${book.cover}`"
          :alt="book.title"
          class="book-cover w-24 shrink-0 rounded-sm object-cover self-start border"
        >
        <div class="flex flex-col min-w-0">
          <h1 class="text-xl font-bold mb-1">
            {{ book.title }}
          </h1>
          <p
            v-if="book.author"
            class="book-author text-xs mt-0.5"
          >
            {{ book.author }}
          </p>
          <p
            v-if="book.date"
            class="book-date text-xs"
          >
            {{ book.date }}
          </p>
          <div class="flex flex-wrap items-center gap-x-4 gap-y-0.5 mt-2 mb-2">
            <a
              v-if="book.url"
              :href="book.url"
              target="_blank"
              rel="noopener"
              class="book-url inline-flex items-center gap-1 text-xs no-underline hover:underline"
            >
              <GIcon
                :name="GIconName.ExternalLink"
                :size="12"
              /> Publisher / Author page
            </a>
            <span
              v-if="book.isbn"
              class="book-isbn text-xs font-mono"
            >ISBN {{ book.isbn }}</span>
          </div>
          <p
            v-if="book.description && !book.parent"
            class="book-description text-xs mt-1 max-w-prose"
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
        class="mb-6"
      >
        <GFilterable
          label="Concepts"
          :columns="1"
          :page-size="PAGE_SIZE"
        >
          <template
            v-if="book.concepts.length > 10"
            #search
          >
            <GFilterableSearchBox placeholder="Filter..." />
          </template>
          <GFilterableItem
            v-for="c in book.concepts"
            :key="c"
            :value="c"
            :label="formatSlug(c)"
          >
            <router-link
              :to="`/journeys/${slug}/concepts/${c}`"
              class="book-concept-link block text-sm no-underline truncate transition-colors py-1 border-b"
            >
              {{ formatSlug(c) }}
            </router-link>
          </GFilterableItem>
        </GFilterable>
      </div>

      <div class="mb-6">
        <h3 class="book-section-label text-xs font-semibold uppercase tracking-wider mb-3 pb-1 border-b">
          Content
        </h3>
        <div
          v-if="content"
          class="prose"
          v-html="content"
        />
        <p
          v-else
          class="book-empty text-sm"
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
  computed, watch, defineAsyncComponent,
} from 'vue';
import {
  useAsyncState,
} from '@vueuse/core';
import {
  useRoute,
} from 'vue-router';
import {
  GIcon, GIconName, GFilterable, GFilterableItem, GFilterableSearchBox,
} from '@hdnax/genuix';
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
import JourneyBreadcrumb from '@/components/common/JourneyBreadcrumb.vue';

const GiscusComment = defineAsyncComponent(() => import('@/components/content/github/GiscusComment.vue'));

const PAGE_SIZE = 10;

const route = useRoute();
const slug = computed(() => route.params.slug as string);
const bookSlug = computed(() => route.params.bookSlug as string);
const bookStore = useBookStore();

const book = computed(() => bookStore.getBySlug(bookSlug.value));

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
  let current = book.value;
  while (current?.parent) {
    const parent = bookStore.getBySlug(current.parent);
    if (!parent) break;
    current = parent;
  }
  return current;
});
const {
  state: content, execute: reloadContent,
} = useAsyncState(
  async () => book.value ? loadContent(book.value.slug) : '',
  '',
);
watch(book, () => reloadContent());

const allJourneyBooks = computed(() => {
  if (!book.value) return [];
  const flat: Book[] = [];
  function collect (slugs: string[]) {
    for (const bookSlugEntry of slugs) {
      const bookEntry = bookStore.getBySlug(bookSlugEntry);
      if (bookEntry) {
        flat.push(bookEntry);
        if (bookEntry.children.length) collect(bookEntry.children);
      }
    }
  }
  const roots = bookStore.getByJourney(slug.value).filter((bookEntry) => !bookEntry.parent);
  collect(roots.map((bookEntry) => bookEntry.slug));
  return flat;
});

const currentIndex = computed(() => allJourneyBooks.value.findIndex((s) => s.slug === bookSlug.value));
const prevChapter = computed(() => allJourneyBooks.value[currentIndex.value - 1]);
const nextChapter = computed(() => allJourneyBooks.value[currentIndex.value + 1]);

</script>

<style>
.book-cover { border-color: color-mix(in oklch, var(--gui-neutral-border) 50%, transparent); }
.book-author { color: var(--gui-neutral-solid); }
.book-date { color: color-mix(in oklch, var(--gui-neutral-solid) 60%, transparent); }
.book-url { color: var(--gui-info-solid); }
.book-isbn { color: color-mix(in oklch, var(--gui-neutral-solid) 60%, transparent); }
.book-description { color: var(--gui-neutral-fg-muted); }
.book-concept-link { color: var(--gui-neutral-fg-muted); border-color: var(--gui-neutral-border); }
.book-concept-link:hover { color: var(--gui-info-solid); }
.book-section-label { color: var(--gui-neutral-solid); border-color: var(--gui-neutral-border); }
.book-empty { color: var(--gui-neutral-solid); }
</style>
