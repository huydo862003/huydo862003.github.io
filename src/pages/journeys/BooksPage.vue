<template>
  <div class="page">
    <div class="top-bar">
      <router-link
        :to="`/journeys/${slug}`"
        class="back"
      >
        &larr; back to journey
      </router-link>
      <Breadcrumb :crumbs="[{ label: 'Journeys', to: '/journeys' }, { label: slug, to: `/journeys/${slug}` }, { label: 'Books', to: `/journeys/${slug}/books` }]" />
    </div>
    <h1>Books</h1>

    <div class="book-list">
      <BookCard
        v-for="book in rootBooks"
        :key="book.slug"
        :book="book"
        :journey-slug="slug"
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
import Breadcrumb from '@/components/BreadcrumbNav.vue';
import { useBookStore } from '@/stores/books';
import BookCard from '@/components/BookCard.vue';

const route = useRoute();
const slug = computed(() => route.params.slug as string);
const bookStore = useBookStore();

const journeyBooks = computed(() => bookStore.getByJourney(slug.value));
const rootBooks = computed(() => journeyBooks.value.filter((b) => !b.parent));
</script>

<style scoped>
@reference "../../style.css";
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
