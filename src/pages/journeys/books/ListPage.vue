<template>
  <div class="page">
    <div class="top-bar">
      <router-link
        :to="`/journeys/${slug}`"
        class="back"
      >
        &larr; back to journey
      </router-link>
      <SBreadcrumb :crumbs="[{ label: 'Journeys', to: '/journeys' }, { label: slug, to: `/journeys/${slug}` }, { label: 'Books', to: `/journeys/${slug}/books` }]" />
    </div>
    <h1>Books</h1>

    <div class="book-list">
      <SCard
        v-for="book in rootBooks"
        :key="book.slug"
        :data="book"
        :config="bookConfig"
      />
    </div>

    <p
      v-if="!rootBooks.length"
      class="empty"
    >
      No books yet.
    </p>
  </div>
</template>

<script setup lang="ts">
import { computed } from 'vue';
import { useRoute } from 'vue-router';
import { PhBook } from '@phosphor-icons/vue';
import SBreadcrumb from '@/components/common/SBreadcrumb.vue';
import { useBookStore } from '@/stores/books';
import SCard from '@/components/content/book/SCard.vue';
import type { SCardConfig } from '@/components/content/book/SCard.vue';
import type { Book } from '@/types/book';

const route = useRoute();
const slug = computed(() => route.params.slug as string);
const bookStore = useBookStore();

const journeyBooks = computed(() => bookStore.getByJourney(slug.value));
const rootBooks = computed(() => journeyBooks.value.filter((b) => !b.parent));

const bookConfig = computed((): SCardConfig<Book> => ({
  titleKey: 'title',
  icon: PhBook,
  routeTemplate: '/journeys/{journeySlug}/books/{slug}',
  routeParams: { journeySlug: slug.value },
  metaKeys: ['author', 'date'],
  childrenResolver: (book) => book.children
    .map((s) => bookStore.getBySlug(s))
    .filter((c): c is NonNullable<typeof c> => !!c),
  renderChildren: true,
}));
</script>

<style scoped>
@reference "../../../style.css";
h1 {
  @apply text-xl font-bold mb-6;
}
.book-list {
  @apply flex flex-col gap-3;
}
.empty {
  @apply text-fg-faint text-sm;
}
</style>
